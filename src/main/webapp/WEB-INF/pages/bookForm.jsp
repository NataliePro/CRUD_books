<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="Natalie Proshkina">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book Information</title>
    <!-- Bootstrap CSS -->
    <%-- <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet"> --%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <style type="text/css">
        .myrow-container{
            margin: 20px;
        }
        .panel-title{
            color: #d1cbbc;
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
    </style>
</head>

<body class=".container-fluid" style="background-color:whitesmoke" >
<div class="container myrow-container">
    <div class="panel panel-success">
        <div class="panel-heading" style="background-color:#786455">
            <h3 class="panel-title" style="color: #d1cbbc">
                Book Details
            </h3>
        </div>
        <div class="panel-body">
            <form:form id="BookRegisterForm" cssClass="form-horizontal" modelAttribute="book" method="post" action="saveBook">

                <div class="form-group">
                    <div class="control-label col-xs-3"> <form:label path="title" >Title</form:label> </div>
                    <div class="col-xs-6">
                        <form:hidden path="id" value="${bookObject.id}"/>
                        <form:input cssClass="form-control" path="title" value="${bookObject.title}" id="title"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="description" cssClass="control-label col-xs-3">Description</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="description" value="${bookObject.description}"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="author" cssClass="control-label col-xs-3">Author</form:label>
                    <div class="col-xs-6">
                        <form:input id="input_author" cssClass="form-control" path="author" value="${bookObject.author}" />
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="isbn" cssClass="control-label col-xs-3">ISBN</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="isbn" value="${bookObject.isbn}"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="control-label col-xs-3"><form:label path="printYear">Print year</form:label></div>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="printYear" value="${bookObject.printYear}" id="printYear"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-4">
                        </div>
                        <div class="col-xs-4">
                            <input type="submit" id="saveBook" class="btn btn-primary" value="Save" onclick="return submitBookForm();"/>
                        </div>
                        <div class="col-xs-4">
                        </div>
                    </div>
                </div>

            </form:form>
        </div>
    </div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        var input_author = $('#input_author').val().trim();
        if (input_author!=''){
            $('#input_author').attr('readonly', 'readonly');
        }else{
            $('#input_author').removeAttr('readonly');
        }
    })
</script>

<script type="text/javascript">
    function submitBookForm() {


        var title = $('#title').val().trim();
        var author = $('#input_author').val().trim();
        var printYear = $('#printYear').val();

        if(author.length ==0) {
            alert('Please enter author');
            $('#input_author').focus();
            return false;
        }

        if(title.length ==0) {
            alert('Please enter title');
            $('#title').focus();
            return false;
        }

        if(printYear < 1800 || printYear>2018 ) {
            alert('Please enter correct print year');
            $('#printYear').focus();
            return false;
        }


        return true;
    };
</script>
</body>
</html>