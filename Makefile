MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := test
.DELETE_ON_ERROR:
.SUFFIXES:

test/output:
	mkdir -p $@

.PHONY: test
test: test_viewcal

.PHONY: test_viewcal
test_viewcal: | test/output
	faketime '2024-12-31' ./viewcal -f test_calendar.txt 2024-01-01 > $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test_calendar.txt today >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test_calendar.txt this today >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2023-12-31' ./viewcal -f test_calendar.txt last today >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt last today >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt next today >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test_calendar.txt yesterday >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test_calendar.txt this yesterday >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test_calendar.txt last yesterday >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test_calendar.txt next yesterday >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt tomorrow >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt this tomorrow >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt last tomorrow >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test_calendar.txt next tomorrow >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test_calendar.txt week >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test_calendar.txt this week >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test_calendar.txt next week >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt last week >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt month >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt this month >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt next month >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt last month >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt this year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt next year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test_calendar.txt last year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-05-31' ./viewcal -f test_calendar.txt -a week >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test_calendar.txt -a month >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test_calendar.txt -a year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test_calendar.txt -a next year >> $|/result.txt
	echo "-----" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test_calendar.txt -a -r year >> $|/result.txt
	echo "-----" >> $|/result.txt
	diff -q test/expected/expected.txt $|/result.txt
	@echo "Test succeeded!"

clean:
	rm -Rf test/output
