DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_likes;

PRAGMA foreign_keys = ON;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL, 
    lname TEXT NOT NULL
);

INSERT INTO
    users (fname, lname)
VALUES
    ("yohan", "oh"), ("dan","blonc"), ("john", "park");


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id) 
);

INSERT INTO 
    questions (title, body, users_id)
VALUES 
    (
        (SELECT 'yohans question' FROM users WHERE fname = "yohan"),
        ("questions number 1"),
        (SELECT id FROM users WHERE fname = 'yohan')

    ),(

        (SELECT 'dans question' FROM users WHERE fname = "dan"),
        ("questions number 2"),
        (SELECT id FROM users WHERE fname = "dan")

    ), (

        (SELECT 'johns question' FROM users WHERE fname = "john"),
        ("questions number 3"),
        (SELECT id FROM users WHERE fname = "john")

    );



CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL, 
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id)
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO 
    question_follows (users_id, questions_id)
VALUES 
    (
       (SELECT id FROM users WHERE fname = "yohan"),
       (SELECT id FROM questions WHERE title = "yohans question")

    ),(
    
        (SELECT id FROM users WHERE fname = "dan"),
       (SELECT id FROM questions WHERE title = "dans question")
 
    ),(
    
        (SELECT id FROM users WHERE fname = "john"),
       (SELECT id FROM questions WHERE title = "johns question")

    );

    CREATE TABLE replies(
        id INTEGER PRIMARY KEY,
        questions_id INTEGER NOT NULL, 
        parent_reply_id INTEGER, 
        users_id INTEGER NOT NULL,
        body TEXT NOT NULL,

        FOREIGN KEY (questions_id) REFERENCES questions(id)
        FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
        FOREIGN KEY (users_id) REFERENCES users(id)
    );

    INSERT INTO 
        replies (questions_id, users_id, body)
    VALUES
        (
            (SELECT id FROM questions WHERE title = "yohans question"),
            (SELECT id FROM users WHERE fname = "yohan"),
            ("Reply 1")


        );

    INSERT INTO 
        replies (questions_id, parent_reply_id, users_id, body)
    VALUES
    (
        (SELECT id FROM questions WHERE title = "yohans question"),
        (SELECT id FROM replies WHERE body = "Reply 1"),
        (Select id FROM users WHERE fname = "dan"),
        ("Reply child")
    );

    INSERT INTO 
        replies (questions_id, parent_reply_id, users_id, body)
    VALUES
    (
        (SELECT id FROM questions WHERE title = "yohans question"),
        (SELECT id FROM replies WHERE body = "Reply child"),
        (Select id FROM users WHERE fname = "john"),
        ("Reply child child")
    );



CREATE TABLE questions_likes(
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    num_of_likes INTEGER DEFAULT 0,
    users_id INTEGER NOT NULL,
    
    FOREIGN KEY (questions_id) REFERENCES questions(id)
    FOREIGN KEY (users_id) REFERENCES users(id)
    );

    INSERT INTO 
        questions_likes (questions_id, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "yohans question"),
        
        (SELECT id FROM users WHERE fname = "yohan")

    );

    INSERT INTO 
        questions_likes (questions_id, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "dans question"),
        
        (SELECT id FROM users WHERE fname = "dan")

    );

    INSERT INTO 
        questions_likes (questions_id, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "johns question"),
        
        (SELECT id FROM users WHERE fname = "john")

    );




    INSERT INTO 
        questions_likes (questions_id, num_of_likes, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "dans question"),
        (SELECT num_of_likes + 1  FROM questions_likes WHERE id = 2),
        (SELECT id FROM users WHERE fname = "yohan")

    );

    INSERT INTO 
        questions_likes (questions_id, num_of_likes, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "yohans question"),
        (SELECT num_of_likes + 1  FROM questions_likes WHERE id = 1),
        (SELECT id FROM users WHERE fname = "dan")

    );

    INSERT INTO 
        questions_likes (questions_id, num_of_likes, users_id)
    VALUES 
    (

        (SELECT id FROM questions WHERE title = "yohans question"),
        (SELECT num_of_likes + 1  FROM questions_likes WHERE id = 5),
        (SELECT id FROM users WHERE fname = "john")

    );







