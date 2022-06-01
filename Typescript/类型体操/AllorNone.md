
```typescript
type AllOrNone<T> = T | {[K in keyof T]?: never};


//Example:
interface A {
    visible: boolean,
    closeModal: () => void
}

interface Base {
    name: string
}

type AA = AllOrNone<A> & Base

//valid
const aa: AA = {
    name: 'fff',
    visible: true,
    closeModal: () => {
        //
    }
}
//valid
const ab: AA = {
    name: 'ggg'
}
//not valid
const ac: AA = {
    name: 'aa',
    closeModal: () => {

    }
}
```