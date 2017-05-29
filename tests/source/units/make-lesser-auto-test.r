REBOL [
	Title:   "Generates Red lesser? and lesser-or-equal? tests"
	Author:  "Peter W A Wood"
	File: 	 %make-lesser-auto-test.r
	Version: 0.1.0
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2015 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

;; initialisations 

make-dir %auto-tests/
infix-file: %auto-tests/infix-lesser-auto-test.red
prefix-file: %auto-tests/lesser-auto-test.red
infix-file2: %auto-tests/infix-lesser-equal-auto-test.red
prefix-file2: %auto-tests/lesser-equal-auto-test.red

test-src: {
Red [
	Title:   "Red infix or prefix lesser? or lesser-or-equal? test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 ***FILE***
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2013, Nenad Rakocevic & Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

comment {  This file is generated by make-equal-auto-test.r
  Do not edit this file directly.
}

;make-length:***MAKELENGTH***           

#include  %../../../../quick-test/quick-test.red
}

;;functions

group-title: ""                         ;; title of current group
group-test-no: 0                        ;; number of current test in group

add-lesser-test: func [
  expected 				[string!]
  actual   				[string!]
  lesser-true			[logic!]
  lesser-equal-true	[logic!]
][
	add-test
	append infix-src join {--assert } 
		compose [(either lesser-true [""] ["not "]) expected  " < " actual newline]
  	append prefix-src join {--assert }
  		compose [(either lesser-true [""] ["not"]) " lesser? " expected " " actual newline]
  	append infix-src2 join {--assert } 
  		compose [(either lesser-equal-true [""] ["not "]) expected  " <= " actual newline]
  	append prefix-src2 join {--assert }
  		compose [(either lesser-equal-true [""]["not"]) " lesser-or-equal? " expected " " actual newline]
]

add-test: func [] [
  group-test-no: group-test-no + 1
  append infix-src join {--test-- "infix-lesser-} 
    [group-title "-" group-test-no {"} newline]
  append prefix-src join {--test-- "prefix-lesser-} 
    [group-title "-" group-test-no {"} newline]
  append infix-src2 join {--test-- "infix-lesser-equal-} 
    [group-title "-" group-test-no {"} newline]
  append prefix-src2 join {--test-- "prefix-lesser-equal-} 
    [group-title "-" group-test-no {"} newline]
]
  
add-test-text: func [
  text  [string!]
][
  append infix-src join replace copy text "***FIX***" "infix" newline
  append prefix-src join replace copy text "***FIX***" "prefix" newline
  append infix-src2 join replace copy text "***FIX***" "infix" newline
  append prefix-src2 join replace copy text "***FIX***" "prefix" newline
]


start-group: func [
  title [string!]
][
  group-title: title
  group-test-no: 0
  add-test-text join {===start-group=== "} [title {"}]
]
  
;; processing 
replace test-src {***MAKELENGTH***} length? read %make-lesser-auto-test.r
infix-src: copy test-src
replace infix-src {***FILE***} :infix-file
prefix-src: copy test-src
replace prefix-src {***FILE***} :prefix-file
infix-src2: copy test-src
replace infix-src2 {***FILE***} :infix-file2
prefix-src2: copy test-src
replace prefix-src2 {***FILE***} :prefix-file2

append infix-src  {~~~start-file~~~ "infix-lesser?"}
append prefix-src  {~~~start-file~~~ "prefix-lesser?"}
append infix-src2  {~~~start-file~~~ "infix-lesser-or-equal?"}
append prefix-src2  {~~~start-file~~~ "prefix-lesser-or-equal?"}

start-group "same-datatype"
add-lesser-test "0" "0" false true
add-lesser-test "0" "1" true true
add-lesser-test "1" "1" false true
add-lesser-test "FFFFFFFFh" "-1" false true
add-lesser-test "FFFFFFFEh" "-1" true true
add-lesser-test "FFFFFFFFh" "-2" false false
;add-lesser-test "[]" "[]" false true
;add-lesser-test "[a]" "[a]" false true
;add-lesser-test "[b]" "[a]" false false
;add-lesser-test "[A]" "[a]" false true
;add-lesser-test "['a]" "[a]" false true
;add-lesser-test "[a:]" "[a]" false true
;add-lesser-test "[:a]" "[a]" false true
;add-lesser-test "[:a]" "[a:]" false true
;add-lesser-test "[abcde]" "[abcde]" false true
;add-lesser-test "[a b c d]" "[a b c d]" false true
;add-lesser-test "[b c d]" "next [a b c d]" false true
;add-lesser-test "[b c d]" "(next [a b c d])" false true
add-lesser-test {"a"} {"a"} false true
add-lesser-test {"a"} {"b"} true true
add-lesser-test {"f"} {"è"} true true
add-lesser-test {"A"} {"a"} false true 
add-lesser-test {"a"} {"A"} false true
add-lesser-test {"abcdeè"} {"abcdeè"} false true
add-lesser-test {(next "abcdeè")} {next "abcdeè"} false true
add-lesser-test {(first "abcdeè")} {first "abcdeè"} false true
add-lesser-test {(last "abcdeè")} {last "abcdeè"} false true
add-lesser-test {"abcde^^(2710)é^^(010000)"} {"abcde^^(2710)é^^(010000)"} false true
;; need to escape the ^ as file is processed by REBOL
;add-lesser-test {[d]} {back tail [a b c d]} false true
add-lesser-test {"2345"} {next "12345"} false true
add-lesser-test {#"z"} {#"z"} false true
add-lesser-test {#"Z"} {#"z"} true true
add-lesser-test {#"e"} {#"è"} true true
add-lesser-test {#"^^(010000)"} {#"^^(010000)"} false true
;add-lesser-test {'a} {'a} false true
;add-lesser-test {'a} {'A} false true
;add-lesser-test {(first [a])} {first [a]} false true
;add-lesser-test {'a} {first [A]} false true
;add-lesser-test {'a} {first ['a]} false true
;add-lesser-test {'a} {first [:a]} false true
;add-lesser-test {'a} {first [a:]} false true
;add-lesser-test {(first [a:])} {first [a:]} false true
;add-lesser-test {(first [:a])} {first [:a]} false true
;add-lesser-test {[a b c d e]} {first [[a b c d e]]} false true
add-test-text {===end-group===}

start-group {implcit-cast}
add-lesser-test {#"0"} {48} false true
add-lesser-test {48} {#"0"} false true
add-lesser-test {#"^^(2710)"} {10000} false true
add-lesser-test {#"^^(010000)"} {65536} false true
add-test-text {===end-group===}

add-test-text {~~~end-file~~~}

write infix-file infix-src
write prefix-file prefix-src
write infix-file2 infix-src2
write prefix-file2 prefix-src2

print "Lesser auto test files generated"

