package ru.proshkina.nata.dao;

import ru.proshkina.nata.model.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class BookDAOImpl implements BookDAO {

    private static final Logger logger = LoggerFactory.getLogger(BookDAOImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(book);
        logger.info("Book successfully saved. Book details: " + book);
    }

    @Override
    public void updateBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.update(book);
        logger.info("Book successfully updated. Book details: "+book);
    }

    @Override
    public void removeBook(int id) {
        Session session = sessionFactory.getCurrentSession();
        Book book = (Book)session.get(Book.class,new Integer(id));
        if (book!=null) {
            session.delete(book);
            logger.info("Book with id "+id+" successfully deleted.");
        }else logger.info("Book with id "+id+" not found");

    }

    @Override
    public Book getBookById(int id) {
        Session session = sessionFactory.getCurrentSession();
        Book book = (Book) session.get(Book.class, new Integer(id));
        logger.info("Book successfully loaded. Book details: " + book);

        return book;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> listBooks() {
        String query = "SELECT t.* FROM book t";
        return getBooksByQuery(query);
    }

    @Override
    public List<Book> listBooksByTitle(String bookTitle) {
        String query = "SELECT t.* FROM book t WHERE t.title like '%"+ bookTitle +"%'";
        return getBooksByQuery(query);
    }

    @Override
    public List<Book> listBooksByYear(int year, String equality) {
        String query = "SELECT t.* FROM book t WHERE t.printYear "+equality+" "+ year;
        return getBooksByQuery(query);
    }

    @Override
    public List<Book> listBookByReadAlready(boolean hasRead) {
        String query = "SELECT t.* FROM book t WHERE t.readAlready = "+hasRead;
        return getBooksByQuery(query);
    }

    @Override
    public List<Book> listBooksByAuthor(String bookAuthor) {
        String query = "SELECT t.* FROM book t WHERE t.author like '%"+ bookAuthor +"%'";
        return getBooksByQuery(query);
    }

    public List<Book> getBooksByQuery(String query){
        List<Object[]> bookObjects = sessionFactory.getCurrentSession().createSQLQuery(query).list();
        List<Book> books = new ArrayList<Book>();
        for(Object[] bookObject: bookObjects) {
            Book book = new Book();
            int id = (Integer) bookObject[0];
            String title = (String) bookObject[1];
            String description = (String) bookObject[2];
            String author = (String) bookObject[3];
            String isbn = (String) bookObject[4];
            int printYear = (Integer) bookObject[5];
            boolean readAlready = (Boolean) bookObject[6];
            book.setId(id);
            book.setTitle(title);
            book.setDescription(description);
            book.setAuthor(author);
            book.setIsbn(isbn);
            book.setPrintYear(printYear);
            book.setReadAlready(readAlready);
            books.add(book);
        }
        return books;
    }
}
