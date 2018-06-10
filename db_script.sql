USE test;
drop table if exists book;
create table book (
	id int(11) not null auto_increment,
    title varchar(100) not null,
    description varchar(255),
    author varchar(100) not null,
    isbn varchar(20),
    printYear int(4),
    readAlready boolean,
    primary key (id)
)
engine = InnoDB
collate utf8_general_ci;

insert into book (id,title,description,author,isbn,printYear,readAlready) 
values (1,'The Apostate','The story The Apostate is about a boy whose childhood is very similar to Jack London. It tells us about the life of children in America at the end of the 19th century.','Jack London','978-5-17-087613-6',1980,false),
(2,'The Bottle Imp','The protagonist buys a bottle with an imp inside that grants wishes. However, the bottle is cursed; if the holder dies bearing it, his or her soul is forfeit to hell','R. Stevenson','0-8248-1397-9',1991,false),
(3,'The Gift of the Magi','short story about a young husband and wife and how they deal with the challenge of buying secret Christmas gifts for each other with very little money','O.Henry','978-0-8222-1461-8',1984,true),
(4,'The Picture of Dorian Gray',null,'Oscar Wilde','9780199535989',2008,true),
(5,'The Lamp',null,'Agatha Christie','9785432135454',1990,false),
(6,'The Adventure of the Lions Mane',null,'Conan Doyle','97848222222',2001,false),
(7,'Great Expectations',null,'Charles Dickens','984165458584',2000,true),
(8,'The Leopard Mans Story','short mystery story by Jack London','Jack London','9564836543521',2008,false),
(9,'The Screaming Woman',null,'Ray Bradbury','68554361111',2001,false),
(10,'The Black Cat','a short story','Edgar Poe','236546451355',1999,false),
(11,'The Green Mile','It tells the story of death row supervisor Paul Edgecombes encounter with John Coffey, an unusual inmate who displays inexplicable healing and empathetic abilities','S. King','548432222445',1996,false),
(12,'Black House','good book','S. King','54774722445',2002,false),
(13,'Danse Macabre',null,'S. King','58787872445',1982,false),
(14,'Misery','ok','S. King','525584544445',1987,true),
(15,'1984','novel is set in the year 1984 when most of the world population have become victims of perpetual war, omnipresent government surveillance and public manipulation','G. Orwell','9888574445',1984,true),
(16,'Fight Club',null,'Chuck Palahniuk','9785452222445',1996,false),
(17,'Lullaby',null,'Chuck Palahniuk','548411122445',2002,false),
(18,'Snuff',null,'Chuck Palahniuk','54814922445',2008,false),
(19,'Invisible Monsters','','Chuck Palahniuk','147452222445',1999,false),
(20,'Rant','','Chuck Palahniuk','9878532212445',2007,true),
(21,'Survivor','','Chuck Palahniuk','7432422445',1999,false),
(22,'Carrie','','S. King','978452445',1996,false);
