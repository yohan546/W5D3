
PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL, 
    lname TEXT NOT NULL
);

INSERT INTO
    users (fname, lname)
VALUES
    ("yohan", "oh"), ("dan","blonc"), ("random", "guy");


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
        (SELECT fname AS name FROM users WHERE fname = "yohan"),
        ("questions number 1"),
        (SELECT id AS users_id FROM users WHERE fname = 'yohan')

    ),
    
        (
        (SELECT fname AS name FROM users WHERE fname = "dan"),
        ("questions number 2"),
        (SELECT id AS users_id FROM users WHERE fname = "dan")

    );


CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL, 
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (users_id) REFERENCES users(id)
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

-- INSERT INTO 
--     questions_follows (users_id, quesetions_id)
-- VALUES 
--     (
--         SELECT * FROM users
--         SELECT  FROM 

--     )

