package ru.proshkina.nata.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.proshkina.nata.dao.BookDAOImpl;
import ru.proshkina.nata.model.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import ru.proshkina.nata.service.BookService;

import java.util.List;

@Controller
public class BookController {

    private static final Logger logger = LoggerFactory.getLogger(BookDAOImpl.class);

    private BookService bookService;
    private static final int MAX_ROWS_PER_PAGE = 10;

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = {"getAllBooks"})
    public ModelAndView getAllBooks(){
        List<Book> books = bookService.listBooks();
        return new ModelAndView("listBooks","listBooks",books);

    }

    @RequestMapping("createBook")
    public ModelAndView createBook(@ModelAttribute Book book) {
        return new ModelAndView("bookForm");
    }

    @RequestMapping("deleteBook")
    public ModelAndView deleteBook(@RequestParam int id)
    {
        bookService.removeBook(id);
        return new ModelAndView("redirect:/");
    }

    @RequestMapping("editBook")
    public ModelAndView editBook(@RequestParam int id, @ModelAttribute Book book) {
        book = bookService.getBookById(id);
        return new ModelAndView("bookForm", "bookObject", book);
    }

    @RequestMapping("readBook")
    public ModelAndView readBook(@RequestParam int id, @ModelAttribute Book book,@RequestParam Integer page) {
        book = bookService.getBookById(id);

        if (book!=null && book.isReadAlready()==false){
            book.setReadAlready(true);
            bookService.updateBook(book);

        }

        ModelAndView modelAndView = new ModelAndView("listBooks");
        List<Book> books = bookService.listBooks();
        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(books);
        pagedListHolder.setPageSize(MAX_ROWS_PER_PAGE);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());
        if (page==null){
            page = 1;
        }
        pagedListHolder.setPage(page-1);
        return modelAndView.addObject("listBooks", pagedListHolder.getPageList());
    }

    @RequestMapping("saveBook")
    public ModelAndView saveBook(@ModelAttribute Book book) {

        if(book.getId() == 0){
            bookService.addBook(book);
        } else {
            if (book.isReadAlready()){
                book.setReadAlready(false);
            }
            bookService.updateBook(book);
        }
        return new ModelAndView("redirect:/");
    }

    @RequestMapping("searchBookByTitle")
    public ModelAndView searchBookByTitle(@RequestParam("searchTitle") String searchTitle){
        List<Book> listBooks = bookService.listBooksByTitle(searchTitle);
        return new ModelAndView("listBooks", "listBooks", listBooks);
    }

    @RequestMapping("searchBookByYear")
    public ModelAndView searchBookByYear(@RequestParam("searchYear") int searchYear, @RequestParam("equality") String equality){
        List<Book> listBooks = bookService.listBooksByYear(searchYear, equality);
        return new ModelAndView("listBooks", "listBooks", listBooks);
    }

    @RequestMapping("searchBookByReadAlready")
    public ModelAndView searchBookByReadAlready(@RequestParam("hasRead") int hasRead){

        boolean read = false;
        if (hasRead==1) read = true;
        List<Book> listBooks = bookService.listBookByReadAlready(read);
        return new ModelAndView("listBooks", "listBooks", listBooks);
    }

    @RequestMapping("searchBookByAuthor")
    public ModelAndView searchBookByAuthor(@RequestParam("searchAuthor") String searchAuthor){
        List<Book> listBooks = bookService.listBooksByAuthor(searchAuthor);
        return new ModelAndView("listBooks", "listBooks", listBooks);

    }

    @RequestMapping(value="/")
    public ModelAndView listOfBooks(@RequestParam(required = false) Integer page) {
        ModelAndView modelAndView = new ModelAndView("listBooks");
        List<Book> books = bookService.listBooks();

        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(books);
        pagedListHolder.setPageSize(MAX_ROWS_PER_PAGE);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            page=1;
        }
        modelAndView.addObject("page", page);
        if(page == null || page < 1 || page > pagedListHolder.getPageCount()){
            pagedListHolder.setPage(0);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        }
        else if(page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page-1);
            modelAndView.addObject("listBooks", pagedListHolder.getPageList());
        }
        return modelAndView;
    }




}
