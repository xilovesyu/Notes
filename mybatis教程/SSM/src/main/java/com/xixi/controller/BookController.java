package com.xixi.controller;

import com.xixi.bean.Book;
import com.xixi.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;

/**
 * Created by xijiaxiang on 2017/5/18.
 */
@Controller
public class BookController {
    @Autowired
    private BookService bookService;

    @RequestMapping("/book/all")
    public ModelAndView booklist(Model model) {
        ModelAndView mav = new ModelAndView("BookList");
        mav.addObject("booklist", bookService.selectAll());
        return mav;
    }

    @RequestMapping("/book/page{page}")
    public ModelAndView bookpage(@PathVariable int page, Model model) {
        ModelAndView mav = new ModelAndView("BookList");
        mav.addObject("booklist", bookService.selectByPageNumSize(page, 10));
        return mav;
    }

    @RequestMapping("/book/new")
    public String insertBookPage() {
        return "BookInsert";
    }

    @RequestMapping("/book/insert")
    public String insertBook(Model model, @Valid @ModelAttribute("book") Book book,  BindingResult result) {
        System.out.println(book.toString());
        if (result.hasErrors()) {
            return "BookInsert";
        } else {
            bookService.insertABook(book);
            ModelAndView mav = new ModelAndView("BookList");
            mav.addObject("booklist", bookService.selectAll());
            return "BookList";
        }
    }
}
