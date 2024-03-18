MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := test
.DELETE_ON_ERROR:
.SUFFIXES:

test/output:
	mkdir -p $@

.PHONY: test
test: test_viewcal test_code

.PHONY: test_code
test_code:
	@echo "Cheking code for style and lint ..."
	pycodestyle --max-line-length=100 --indent-size=2 viewcal
	flake8 --max-line-length=100 --indent-size=2 viewcal
	@echo "Test succeeded!"

.PHONY: test_viewcal test_code
test_viewcal: | test/output
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt 2024-01-01 > $|/result.txt
	echo "---TC01 Completed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt today >> $|/result.txt
	echo "---TC02 Completed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal -f test/test_calendar.txt this today >> $|/result.txt
	echo "---TC03 Completed---" >> $|/result.txt
	faketime '2023-12-31' ./viewcal -f test/test_calendar.txt last today >> $|/result.txt
	echo "---TC04 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt last today >> $|/result.txt
	echo "---TC05 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt next today >> $|/result.txt
	echo "---TC06 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt yesterday >> $|/result.txt
	echo "---TC07 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt this yesterday >> $|/result.txt
	echo "---TC08 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt last yesterday >> $|/result.txt
	echo "---TC09 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal -f test/test_calendar.txt next yesterday >> $|/result.txt
	echo "---TC10 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt tomorrow >> $|/result.txt
	echo "---TC11 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt this tomorrow >> $|/result.txt
	echo "---TC12 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt last tomorrow >> $|/result.txt
	echo "---TC13 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt next tomorrow >> $|/result.txt
	echo "---TC14 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt week >> $|/result.txt
	echo "---TC15 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt this week >> $|/result.txt
	echo "---TC16 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal -f test/test_calendar.txt next week >> $|/result.txt
	echo "---TC17 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last week >> $|/result.txt
	echo "---TC18 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt month >> $|/result.txt
	echo "---TC19 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt this month >> $|/result.txt
	echo "---TC20 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt next month >> $|/result.txt
	echo "---TC21 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last month >> $|/result.txt
	echo "---TC22 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt year >> $|/result.txt
	echo "---TC23 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt this year >> $|/result.txt
	echo "---TC24 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt next year >> $|/result.txt
	echo "---TC25 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal -f test/test_calendar.txt last year >> $|/result.txt
	echo "---TC26 Completed---" >> $|/result.txt
	faketime '2024-05-31' ./viewcal -f test/test_calendar.txt -a week >> $|/result.txt
	echo "---TC27 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a month >> $|/result.txt
	echo "---TC28 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a year >> $|/result.txt
	echo "---TC29 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a next year >> $|/result.txt
	echo "---TC30 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal -f test/test_calendar.txt -a -r year >> $|/result.txt
	echo "---TC31 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt monday >> $|/result.txt
	echo "---TC32 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt tuesday >> $|/result.txt
	echo "---TC33 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt wednesday >> $|/result.txt
	echo "---TC34 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt thursday >> $|/result.txt
	echo "---TC35 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt friday >> $|/result.txt
	echo "---TC36 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt saturday >> $|/result.txt
	echo "---TC37 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt sunday >> $|/result.txt
	echo "---TC38 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt next tuesday >> $|/result.txt
	echo "---TC39 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal -f test/test_calendar.txt last thursday >> $|/result.txt
	echo "---TC40 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal -f test/test_calendar.txt march >> $|/result.txt
	echo "---TC41 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal -f test/test_calendar.txt january >> $|/result.txt
	echo "---TC42 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal -f test/test_calendar.txt february >> $|/result.txt
	echo "---TC43 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal -f test/test_calendar.txt next january >> $|/result.txt
	echo "---TC44 Completed---" >> $|/result.txt
	faketime '2024-12-01' ./viewcal -f test/test_calendar.txt last december >> $|/result.txt
	echo "---TC45 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt 2024-02 >> $|/result.txt
	echo "---TC46 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt 2024 >> $|/result.txt
	echo "---TC47 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt 2025 >> $|/result.txt
	echo "---TC48 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt 2023 >> $|/result.txt
	echo "---TC49 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -f test/test_calendar.txt 2023-12 >> $|/result.txt
	echo "---TC50 Completed---" >> $|/result.txt
	diff -q test/expected/expected.txt $|/result.txt
	@echo "Test succeeded!"

clean:
	rm -Rf test/output