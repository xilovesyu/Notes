### Jest 基本使用

[Jest](https://jestjs.io/docs/getting-started) 是前端的测试框架，用来写js，ts的单元测试。本篇文章会重点介绍怎么写unit test， 怎么mock，怎么设计测试用例。

#### Describe, it 和 test

Jest 利用 describe 来描述一个测试套件，一个测试套件可以包含子的测试套件，也可以直接包含测试用例。
Jest 利用 it/test 来描述一个测试用例。

所以基本上结构就如下所示：

```javascript
describe('demo jest test', () => {
    describe('nest jest describle, not mandatory', () => {
        test('test a plus b', () => {
            expect(1-2).toBe(-1)
        })
    })

    test('test a plus b', () => {
        expect(1+2).toBe(3)
    })
})
```

当你还没有想好测试用例怎么写时，可以利用 it.todo/test.todo

```javascript
const add = (a, b) => a + b;

test.todo('add should be associative');
```

当你想要在开始测试前初始化一些操作，可以利用 beforeAll, beforeEach。 当你想要在测试结束后做一些操作，可以利用 afterAll, afterEach。 这里给一个简单的mobx store来举例。

```javascript
import { action, observable } from 'mobx'

class SimpleStore {
    @observable pageSize = 5
    @observable page = 0

    apiService: {fetch: (params: {limit: number, offset: number}) => Promise<any[]>} | null = null

    setApiService(apiService) {
        this.apiService = apiService
    }

    @action
    setPageSize(pageSize) {
        this.pageSize = pageSize
    }

    @action
    setPage(page) {
        this.page = page
    }

    @action
    async loadPageData() {
        if (this.apiService) {
            const limit = this.pageSize
            const offset = this.pageSize * this.page

            const result = await this.apiService.fetch({limit, offset})

            return result
        }
        return []
    }
}

describe('test simple store', () => {
    let store: SimpleStore | undefined
    let mockResults: any[] = []
    beforeAll(() => {
        store = new SimpleStore()
        mockResults = [...Array(100).keys()].map(one => ({id: one}))
    })
    beforeEach(() => {
        const apiService = {
            fetch: async (params) => {
                const result = mockResults.slice(params.offset, params.offset + params.limit)
                return Promise.resolve(result)
            }
        }
        store?.setApiService(apiService)
        store?.setPageSize(5)
        store?.setPage(0)
    })
    afterAll(() => {
        store = undefined
        mockResults = []
    });
    afterEach(() => {
        // no need here
        console.log('after each')
    })

    it('can change pagesize', async () => {
        expect(store?.pageSize).toBe(5)
        store?.setPageSize(10)
        expect(store?.pageSize).toBe(10)

        const result = await store?.loadPageData()
        expect(result).toHaveLength(10)
    });
})
```

#### expect

expect 是用来写实际值和期望值的结果的语句。基本语法如下：

`expect(value).toBe()`

实际上 expect 用法很多，详细可以参考 https://jestjs.io/docs/expect#expect 。 这里我们介绍常见的用法。

##### expect value

最常见的就是判断两个值是否相等或者不等。这时候要看value 是不是primary 类型，如果是primary 类型的话，就可以用`toBe`，否则应该利用`toEqual`, `toStrictEqual`。 如果需要判断不等或者resolve，reject promise。可以利用`not`, `resolves`, `rejects`。 以下是一些示例。

```javascript
expect(1+2).toBe(3)
expect({foo: 'bar'}).toEqual({foo: 'bar'})

expect([]).not.toEqual([1,2])
expect(Promise.resolve(123)).resolves.toBe(123)
expect(Promise.reject('Error'))
expect(Promise.reject('Error')).rejects.toBe('Error')
expect(Promise.reject( new Error('Error'))).rejects.toThrow('Error')
```

还有一类是校验mock的函数是不是被call过，就需要利用`toHaveBeenCalled`。以下是一些举例：

```javascript
function drinkAll(callback, flavour) {
  if (flavour !== 'octopus') {
    callback(flavour);
  }
}

describe('drinkAll', () => {
  test('drinks something lemon-flavoured', () => {
    const drink = jest.fn();
    drinkAll(drink, 'lemon');
    expect(drink).toHaveBeenCalled();
  });

  test('does not drink something octopus-flavoured', () => {
    const drink = jest.fn();
    drinkAll(drink, 'octopus');
    expect(drink).not.toHaveBeenCalled();
  });
});
```

```javascript
test('registration applies correctly to orange La Croix', () => {
  const beverage = new LaCroix('orange');
  register(beverage);
  const f = jest.fn();
  applyToAll(f);
  expect(f).toHaveBeenCalledWith(beverage);
});
```
#### Jest.fn, Jest.mock 和 Jest.spyOn

当我们要测试一些大型的store，function时，往往牵涉到许多额外的模块函数，而我们是没有办法在测试环境提供的。这时候我们就需要mock一些函数，模块，和功能。

##### Jest.fn

这是立即创建一个mock function的方式，上面的在测试`toHaveBeenCalled`时已经用过。我们可以拿变量记住这个创建出来的mock function。我们可以实现这个mockFunction，模拟返回值。

```javascript
const mockFn = jest.fn()
// 模拟实现
mockFn.mockImplementation((a: number, b: number) => {
    return a + b
})
const testFunction = (addFunction: Function, a: number, b: number) => {
    return addFunction(a, b)
}
const result = testFunction(mockFn, 1,2)
expect(mockFn).toHaveBeenCalledWith(1, 2)
expect(result).toBe(3)

// 直接模拟返回值
mockFn.mockReturnValue(4)
const result2 = testFunction(mockFn, 1,2)
expect(result2).not.toBe(3)
expect(result2).toBe(4)

```

##### Jest.mock

当你有一个module 需要整体mock时，这个时候这个方法就是很有用了。我们可以直接利用`jest.mock(modulePath)`模拟一个模块，同时还可以`jest.mock(modulePath, function)`对模块里的一些内容重新实现。同时还可以利用`jest.requireActual(modulePath)`再保留原有真实的导出基础上mock其他的值。以下是一些举例。

```javascript
//testSong.ts
export const song = {
    one: {
        more: {
            time: (t: number) => {
                return t
            },
        },
    },
}

export const songIndividual = (songName: string) => {
    const songText = `sing song, ${songName}`
    // eslint-disable-next-line no-console
    console.log(songText)

    return songText
}
```

```javascript
//完全mock testSong 模块
it.only('jest mock function', () => {
    jest.mock('./testSong')
    const {songIndividual} = require('./testSong')
    const result = songIndividual('aaa')
    expect(result).not.toBeDefined()
})
```
```javascript
//只mock一部分，这里我们只mock了song的内容
it.only('jest mock function2', () => {
    jest.mock('./testSong', () => {
        return {
            song: {
                one: {
                    more: {
                        time: jest.fn()
                    }
                }
            }
        }
    })
    const {songIndividual, song} = require('./testSong')
    expect(song).toBeDefined()
    expect(song.one.more.time).toBeDefined()
    expect(songIndividual).not.toBeDefined()

    const mockFunction = song.one.more.time
    mockFunction()
    expect(mockFunction).toHaveBeenCalledTimes(1)
})
```

```javascript
it.only('jest mock function3', () => {
    jest.mock('./testSong', () => {
        return {
            // 先把真实的require进来
            ...jest.requireActual('./testSong'),
            // 然后模拟 song
            song: {
                one: {
                    more: {
                        time: jest.fn()
                    }
                }
            }
        }
    })
    const {songIndividual, song} = require('./testSong')
    expect(song).toBeDefined()
    expect(song.one.more.time).toBeDefined()
    expect(songIndividual).toBeDefined()

    const result = songIndividual('Greeting')
    expect(result).toBe(`sing song, Greeting`)
})
```
##### Jest.spyOn

和 jest.fn 类似，但是你可以单独为object的某一个方法进行模拟，并且spyOn可以在测试完成后清除掉该mock。以下是举例：

```javascript
// video.ts
const video = {
  play() {
    return true;
  },
};

module.exports = video;
```

```javascript
const video = require('./video');

afterEach(() => {
  // restore the spy created with spyOn
  jest.restoreAllMocks();
});

test('plays video', () => {
  const spy = jest.spyOn(video, 'play');
  const isPlaying = video.play();

  expect(spy).toHaveBeenCalled();
  expect(isPlaying).toBe(true);
});
```

#### ClearMocks, resetAllMocks 和 restoreAllMocks

详细请参见： https://dev.to/edwinwong90/jestclearallmocks-vs-jestresetallmocks-vs-jestrestoreallmocks-explained-5aal
