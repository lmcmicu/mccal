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
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt 2024-01-01 > $|/result.txt
	echo "---TC01 Passed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt today >> $|/result.txt
	echo "---TC02 Passed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt this today >> $|/result.txt
	echo "---TC03 Passed---" >> $|/result.txt
	faketime '2023-12-31' ./viewcal -f test/test_calendar.txt last today >> $|/result.txt
	echo "---TC04 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt last today >> $|/result.txt
	echo "---TC05 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt next today >> $|/result.txt
	echo "---TC06 Passed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt yesterday >> $|/result.txt
	echo "---TC07 Passed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt this yesterday >> $|/result.txt
	echo "---TC08 Passed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt last yesterday >> $|/result.txt
	echo "---TC09 Passed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt next yesterday >> $|/result.txt
	echo "---TC10 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt tomorrow >> $|/result.txt
	echo "---TC11 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt this tomorrow >> $|/result.txt
	echo "---TC12 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt last tomorrow >> $|/result.txt
	echo "---TC13 Passed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt next tomorrow >> $|/result.txt
	echo "---TC14 Passed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt week >> $|/result.txt
	echo "---TC15 Passed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt this week >> $|/result.txt
	echo "---TC16 Passed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt next week >> $|/result.txt
	echo "---TC17 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last week >> $|/result.txt
	echo "---TC18 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt month >> $|/result.txt
	echo "---TC19 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt this month >> $|/result.txt
	echo "---TC20 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt next month >> $|/result.txt
	echo "---TC21 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last month >> $|/result.txt
	echo "---TC22 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt year >> $|/result.txt
	echo "---TC23 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt this year >> $|/result.txt
	echo "---TC24 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt next year >> $|/result.txt
	echo "---TC25 Passed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last year >> $|/result.txt
	echo "---TC26 Passed---" >> $|/result.txt
	faketime '2024-05-31' ./viewcal -f test/test_calendar.txt -a week >> $|/result.txt
	echo "---TC27 Passed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a month >> $|/result.txt
	echo "---TC28 Passed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a year >> $|/result.txt
	echo "---TC29 Passed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a next year >> $|/result.txt
	echo "---TC30 Passed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a -r year >> $|/result.txt
	echo "---TC31 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt monday >> $|/result.txt
	echo "---TC32 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt tuesday >> $|/result.txt
	echo "---TC33 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt wednesday >> $|/result.txt
	echo "---TC34 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt thursday >> $|/result.txt
	echo "---TC35 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt friday >> $|/result.txt
	echo "---TC36 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt saturday >> $|/result.txt
	echo "---TC37 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt sunday >> $|/result.txt
	echo "---TC38 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt next tuesday >> $|/result.txt
	echo "---TC39 Passed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt last thursday >> $|/result.txt
	echo "---TC40 Passed---" >> $|/result.txt
	diff -q test/expected/expected.txt $|/result.txt
	@echo "Test succeeded!"

clean:
	rm -Rf test/output
