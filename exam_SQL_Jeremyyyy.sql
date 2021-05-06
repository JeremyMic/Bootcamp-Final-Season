CREATE DATABASE exam_sql

USE exam_sql

CREATE TABLE Users(
	UserID char(5),
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
	School varchar(255) NOT NULL,
	AddressUser varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	PhoneNumber varchar(255) NOT NULL,
	LocationUser varchar(255) NOT NULL,
	DateOfBirth date NOT NULL,
	Gender varchar(6) NOT NULL,
	CONSTRAINT UsersPK PRIMARY KEY(UserID),
	CONSTRAINT UsersPKCheck CHECK(UserID like 'US[0-9][0-9][0-9]')
)

select * from Users

CREATE TABLE Posts(
	PostID char(5),
	postDate date,
	postContent varchar(255),
	UserID char(5),
	CONSTRAINT PostsPK PRIMARY KEY(PostID),
	CONSTRAINT PostsFK FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT PostsPKCheck CHECK(PostID like 'PO[0-9][0-9][0-9]'),
	CONSTRAINT UsersFKCheck CHECK(UserID like 'US[0-9][0-9][0-9]')
)

CREATE TABLE PostLikes(
	UserID char(5),
	PostID char(5),
	CONSTRAINT PostLikesFK1 FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT PostLikesFK2 FOREIGN KEY(PostID) REFERENCES Posts(PostID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT PostLikesFK1Check CHECK(PostID like 'PO[0-9][0-9][0-9]'),
	CONSTRAINT PostLikesFK2Check CHECK(UserID like 'US[0-9][0-9][0-9]')
)

CREATE TABLE Shares(
	UserID char(5),
	PostID char(5),
	CONSTRAINT SharesFK1 FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT SharesFK2 FOREIGN KEY(PostID) REFERENCES Posts(PostID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT SharesFK1Check CHECK(PostID like 'PO[0-9][0-9][0-9]'),
	CONSTRAINT SharesFK2Check CHECK(UserID like 'US[0-9][0-9][0-9]')
)

CREATE TABLE Photos(
	PhotoID char(5),
	PostID char(5),
	imageContent varchar(255),
	CONSTRAINT PhotosPK PRIMARY KEY(PhotoID),
	CONSTRAINT PhotosFK FOREIGN KEY(PostID) REFERENCES Posts(PostID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT PhotosPKCheck CHECK(PhotoID like 'PH[0-9][0-9][0-9]'),
	CONSTRAINT PhotosFKCheck CHECK(PostID like 'PO[0-9][0-9][0-9]')
)

CREATE TABLE Comments(
	CommentID char(5),
	CommentContent varchar(255),
	UserID char(5),
	PostID char(5),
	CommentDate date,
	CONSTRAINT CommentsPK PRIMARY KEY(CommentID),
	CONSTRAINT CommentsFK1 FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT CommentsFK2 FOREIGN KEY(PostID) REFERENCES Posts(PostID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CommentsPKCheck  CHECK(CommentID like 'CO[0-9][0-9][0-9]'),
	CONSTRAINT CommentsFK1Check CHECK(UserID like 'US[0-9][0-9][0-9]'),
	CONSTRAINT CommentsFK2Check CHECK(PostID like 'PO[0-9][0-9][0-9]')
)

CREATE TABLE CommentLikes(
	CommentID char(5),
	UserID char(5),
	CONSTRAINT CommentLikesFK1 FOREIGN KEY(CommentID) REFERENCES Comments(CommentID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CommentLikesFK2 FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT CommentLikesFK1Check CHECK(CommentID like 'CO[0-9][0-9][0-9]'),
	CONSTRAINT CommentLikesFK2Check CHECK(UserID like 'US[0-9][0-9][0-9]')
)

CREATE TABLE Friends(
	FriendID char(5),
	UserID char(5),
	CONSTRAINT FriendsPK PRIMARY KEY(FriendID),
	CONSTRAINT FriendsFK FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT FriendsPKCheck CHECK(FriendID like 'FR[0-9][0-9][0-9]'),
	CONSTRAINT FriendsFKCheck CHECK(UserID like 'US[0-9][0-9][0-9]')
)

CREATE TABLE Pages(
	PageID char(5),
	PageName varchar(255),
	pageContent varchar(255),
	CONSTRAINT PagesPK PRIMARY KEY(PageID),
	CONSTRAINT PagesPKCheck CHECK(PageID like 'PA[0-9][0-9][0-9]')
)

CREATE TABLE PageLikes(
	UserID char(5),
	PageID char(5),
	CONSTRAINT PageLikesFK1 FOREIGN KEY(UserID) REFERENCES Users(UserID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT PageLikesFK2 FOREIGN KEY(PageID) REFERENCES Pages(PageID)
		ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT PageLikesFK1Check CHECK(UserID like 'US[0-9][0-9][0-9]'),
	CONSTRAINT PageLikesFK2Check CHECK(PageID like 'PA[0-9][0-9][0-9]')
)

