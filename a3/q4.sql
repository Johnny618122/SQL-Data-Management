CREATE TABLE q4(
        student_id VARCHAR(10),
        question_id INT,
        question_text TEXT
);

-- Students'responses for true-false questions, and the answer is NULL.
insert into q4
	SELECT student_id, question_id, question_text
	FROM response_to_tf res, question_bank
	WHERE res.quiz_id = 'Pr1-220310' and res.question_id = question_bank.id and student_answer is null;

-- Students'responses for multiple choice questions, and the answer is NULL.
insert into q4
	SELECT student_id, question_id, question_text
	FROM response_to_mc res, question_bank
	WHERE res.quiz_id = 'Pr1-220310' and res.question_id = question_bank.id and student_answer is null;

-- Students'responses for numeric questions, and the answer is NULL.
insert into q4
	SELECT student_id, question_id, question_text
	FROM response_to_nm res, question_bank
	WHERE res.quiz_id = 'Pr1-220310' and res.question_id = question_bank.id and student_answer is null;
