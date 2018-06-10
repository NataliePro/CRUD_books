<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>Books Page</title>

    <style type="text/css">
        #search{
            background: aliceblue;
        }
        .search_row{
            float: left;
            margin-left: 10px;

        }
        .myrow-container {
            margin: 20px;
        }
        .myrow{
            text-align: left;
            border: blue 3px;
        }
        td {
            border: 2px solid black;
        }


        .btn {
            padding: 2px 2px;
            width: 5em;
            height: 2em;
            background-color: #4d3a1e;
            color: #f1f1f1;
            border-radius: 0;
            transition: .2s;
        }

        .btn:hover, .btn:focus {
            border: 1px solid #4d3a1e;
            background-color: #fff;
            color: #000;
        }

        a.aEdit:link, a.aDelete:link, a.aRead:link {
            color: #a83016;
        }

        a.aEdit:visited, a.aDelete:visited, a.aRead:visited {
            color: #947872;
        }

        a.aEdit:hover, a.aDelete:hover, a.aRead:hover {
            color: #60a870;
        }

        a.aEdit:active, a.aDelete:active, a.aRead:active {
            color: #ded728;
        }

        a.aCreateBook:link {
            color: #d1cbbc;
        }

        a.aCreateBook:visited {
            color: #c4bba5;
        }

        a.aCreateBook:hover {
            color: #a0cc95;
        }

        .panel-footer a{
            font-size: 1.2em;
        }
        .panel-footer a:link {
            color: #d1cbbc;
        }

        .panel-footer a:visited {
            color: #c4bba5;
        }

        .panel-footer a:hover {
            color: #a0cc95;
        }

        .panel-footer a:active {
            color: #ded728;
        }
    </style>
</head>
<body class=".container-fluid" style="background-color:whitesmoke">
<div class="container myrow-container">
    <div class="panel">
        <div class="panel-heading" style="background-color:#786455">
            <h3 class="panel-title ">
                <div align="left" style="color: #d1cbbc"><a>Most interesting books</a></div>
            </h3>
        </div>
        <form action="/createBook">
            <div class="row">
                <div class="col-md-2">Add new book:</div>
                <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Add'/></div>
            </div>
        </form>
        <div class="panel-body">
            <c:if test="${empty listBooks}">
                There are no books
            </c:if>
            <c:if test="${not empty listBooks}">


                <table class="table table-hover table-bordered">
                    <thead style="background-color: #b39b89;">
                    <tr>
                        <th>Id</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Author</th>
                        <th>ISBN</th>
                        <th>Print year</th>
                        <th>Read already</th>
                        <th>Read</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listBooks}" var="book">
                    <tr>
                        <th><c:out value="${book.id}"/></th>
                        <th class="myrow"><c:out value="${book.title}"/></th>
                        <th class="myrow"><c:out value="${book.description}"/></th>
                        <th class="myrow"><c:out value="${book.author}"/></th>
                        <th><c:out value="${book.isbn}"/></th>
                        <th><c:out value="${book.printYear}"/></th>
                        <th><c:out value="${book.readAlready=='false'?'-':'+'}"/></th>
                        <th><a class="aRead" href="readBook?id=<c:out     value='${book.id}'/>&page=<c:out value='${page}'/>" onclick="return <c:out value='${!book.readAlready}'/>;">Read</a></th>
                        <th><a class="aEdit" href="editBook?id=<c:out     value='${book.id}'/>">Edit  </a></th>
                        <th><a class="aDelete" href="deleteBook?id=<c:out value='${book.id}'/>">Delete</a></th>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>



            </c:if>
        </div>
        <div align="center" class="panel-footer" style="background-color:#786455" id="pagination">
            <c:url value="/" var="prev">
                <c:param name="page" value="${page-1}"/>
            </c:url>
            <c:if test="${page > 1}">
                <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
            </c:if>

            <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                <c:choose>
                    <c:when test="${page == i.index}">
                        <span>${i.index}</span>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/" var="url">
                            <c:param name="page" value="${i.index}"/>
                        </c:url>
                        <a href='<c:out value="${url}" />'>${i.index}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:url value="/" var="next">
                <c:param name="page" value="${page + 1}"/>
            </c:url>
            <c:if test="${page + 1 <= maxPages}">
                <a href='<c:out value="${next}" />' class="pn next">Next</a>
            </c:if>
        </div>
    </div>

    <div id="search" class="search">
        <form action="/searchBookByTitle">
            <div class="search_row">
                <div class="col-md-2">Search book by title:</div>
                <div class="col-md-2"><input type="text" name="searchTitle" id="searchTitle"
                                             placeholder="type title here.."></div>
                <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search'/></div>
            </div>
        </form>
        <form action="/searchBookByAuthor">
            <div class="search_row">
                <div class="col-md-2">Search book by author:</div>
                <div class="col-md-2"><input type="text" name="searchAuthor" id="searchAuthor"
                                             placeholder="type author here.."></div>
                <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search'/></div>
            </div>
        </form>
        <form action="/searchBookByYear">
            <div class="search_row">
                <div class="col-md-2">Search book by year:</div>
                <div class="col-md-2">
                    <select name="equality" id="equality">
                        <option value="=">" = "</option>
                        <option value=">">" > "</option>
                        <option value="<">" < "</option>
                    </select>
                    <input type="text" name="searchYear" id="searchYear" placeholder="type year here.."></div>
                <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search'/></div>
            </div>
        </form>
        <form action="/searchBookByReadAlready">
            <div class="search_row">
                <div class="col-md-2">Search book by already read:</div>
                <div class="col-md-2">
                    <select name="hasRead" id="hasRead">
                        <option value="1">" Read "</option>
                        <option value="0">" Unread "</option>
                    </select>
                <div class="col-md-2"><input class="btn btn-xs" type='submit' value='Search' "/></div>
            </div>
            </div>
        </form>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


</div>
</body>
</html>
