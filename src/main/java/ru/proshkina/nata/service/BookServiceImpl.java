package ru.proshkina.nata.service;

import ru.proshkina.nata.dao.BookDAO;
import ru.proshkina.nata.model.Book;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    private BookDAO bookDAO;

    public void setBookDAO(BookDAO bookDAO) {
        this.bookDAO = bookDAO;
    }

    @Override
    @Transactional
    public void addBook(Book book) {
        bookDAO.addBook(book);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        bookDAO.updateBook(book);
    }

    @Override
    @Transactional
    public void removeBook(int id) {
        bookDAO.removeBook(id);
    }

    @Override
    @Transactional
    public Book getBookById(int id) {
        return bookDAO.getBookById(id);
    }

    @Override
    @Transactional
    public List<Book> listBooks() {
        return bookDAO.listBooks();
    }

    @Override
    @Transactional
    public List<Book> listBooksByTitle(String bookTitle) {
        return bookDAO.listBooksByTitle(bookTitle);
    }

    @Override
    @Transactional
    public List<Book> listBooksByYear(int year, String equality) {
        return bookDAO.listBooksByYear(year,equality);
    }

    @Override
    @Transactional
    public List<Book> listBookByReadAlready(boolean hasRead) {
        return bookDAO.listBookByReadAlready(hasRead);
    }

    @Override
    @Transactional
    public List<Book> listBooksByAuthor(String bookAuthor) {
        return bookDAO.listBooksByAuthor(bookAuthor);
    }
}
