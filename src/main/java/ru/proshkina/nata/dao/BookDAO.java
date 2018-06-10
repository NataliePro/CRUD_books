package ru.proshkina.nata.dao;

import ru.proshkina.nata.model.Book;

import java.util.List;

public interface BookDAO {

    public void addBook(Book book);

    public void updateBook(Book book);

    public void removeBook(int id);

    public Book getBookById(int id);

    public List<Book> listBooks();

    public List<Book> listBooksByTitle(String bookTitle);

    public List<Book> listBooksByYear(int year,String equality);

    public List<Book> listBookByReadAlready(boolean hasRead);

    public List<Book> listBooksByAuthor(String bookAuthor);
}
