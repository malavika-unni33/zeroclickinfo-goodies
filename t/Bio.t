#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use DDG::Test::Goodie;

zci is_cached => 1;
zci answer_type => 'bio';

my $test_seq = "TTTATAAGAAACAAAAAAAAGAAAUAAAAAATGAGTAATACTTCUUCGTACGAGAAGAATAATCCAGATAATCTGAAACACAAUGGTATTACCATAGATTCTGAGTUUCTAACTCAGGAGCCAATAACCATTCCCTCAAATGGCTCCGCTGTTTCTATTGACGAAACAGGTTCAGGGTCCAAATGGCAAGACTTTAAAGATTCTTTCAAAAGGGTAAAACCTATTGAAGTTGATCCTAATCTTTCAGAAGCTGAAAAAGTGGCTATCATCACTGCCCAAACTCCATTGAAGCACCACTTGAAGAATAGACATTTGCAAATGATTGCCATCGGTGGTGCCATCGGTACTGGTCTGCTGGTTGGGTCAGGTACTGCACTAAGAACAGGTGGTCCCGCTTCGCTACTGATTGGATGGGGGTC";
#GAP1 from -30 to +190, with some T's -> U's from yeastgenome.org

ddg_goodie_test(
	['DDG::Goodie::Bio'],
	'bio c '.$test_seq 		=> test_zci("Complementary sequence: AAATATTCTTTGTTTTTTTTCTTTATTTTTTACTCATTATGAAGAAGCATGCTCTTCTTATTAGGTCTATTAGACTTTGTGTTACCATAATGGTATCTAAGACTCAAAGATTGAGTCCTCGGTTATTGGTAAGGGAGTTTACCGAGGCGACAAAGATAACTGCTTTGTCCAAGTCCCAGGTTTACCGTTCTGAAATTTCTAAGAAAGTTTTCCCATTTTGGATAACTTCAACTAGGATTAGAAAGTCTTCGACTTTTTCACCGATAGTAGTGACGGGTTTGAGGTAACTTCGTGGTGAACTTCTTATCTGTAAACGTTTACTAACGGTAGCCACCACGGTAGCCATGACCAGACGACCAACCCAGTCCATGACGTGATTCTTGTCCACCAGGGCGAAGCGATGACTAACCTACCCCCAG"),
	'bio r '.$test_seq 		=> test_zci("Reverse sequence: CTGGGGGTAGGTTAGTCATCGCTTCGCCCTGGTGGACAAGAATCACGTCATGGACTGGGTTGGTCGTCTGGTCATGGCTACCGTGGTGGCTACCGTTAGTAAACGTTTACAGATAAGAAGTTCACCACGAAGTTACCTCAAACCCGTCACTACTATCGGTGAAAAAGTCGAAGACTTTCTAATCCTAGTTGAAGTTATCCAAAATGGGAAAACTTTCTTAGAAATTTCAGAACGGTAAACCTGGGACTTGGACAAAGCAGTTATCTTTGTCGCCTCGGTAAACTCCCTTACCAATAACCGAGGACTCAATCUUTGAGTCTTAGATACCATTATGGUAACACAAAGTCTAATAGACCTAATAAGAAGAGCATGCUUCTTCATAATGAGTAAAAAAUAAAGAAAAAAAACAAAGAATATTT"),
	'bio rc '.$test_seq 	=> test_zci("Reverse-Complementary sequence: GACCCCCATCCAATCAGTAGCGAAGCGGGACCACCTGTTCTTAGTGCAGTACCTGACCCAACCAGCAGACCAGTACCGATGGCACCACCGATGGCAATCATTTGCAAATGTCTATTCTTCAAGTGGTGCTTCAATGGAGTTTGGGCAGTGATGATAGCCACTTTTTCAGCTTCTGAAAGATTAGGATCAACTTCAATAGGTTTTACCCTTTTGAAAGAATCTTTAAAGTCTTGCCATTTGGACCCTGAACCTGTTTCGTCAATAGAAACAGCGGAGCCATTTGAGGGAATGGTTATTGGCTCCTGAGTTAGAAACTCAGAATCTATGGTAATACCATTGTGTTTCAGATTATCTGGATTATTCTTCTCGTACGAAGAAGTATTACTCATTTTTTATTTCTTTTTTTTGTTTCTTATAAA"),
	'bio tln '.$test_seq	=> test_zci("Translated, got:

\tFrame 1: FIRNKKKK {STOP} K {START} MSNTSSYEKNNPDNLKHNGITIDSEFLTQEPITIPSNGSAVSIDETGSGSKWQDFKDSFKRVKPIEVDPNLSEAEKVAIITAQTPLKHHLKNRHLQMIAIGGAIGTGLLVGSGTALRTGGPASLLIGWG

\tFrame 2: L {STOP} ETKKRNKK {STOP} VILLRTRRIIQII {STOP} NT {START} MVLP {STOP} ILSF {STOP} LRSQ {STOP} PFPQ {START} MAPLFLLTKQVQGPNGKTLKILSKG {STOP} NLLKLILIFQKLKKWLSSLPKLH {STOP} STT {STOP} RIDICK {STOP} LPSVVPSVLVCWLGQVLH {STOP} EQVVPLRY {STOP} LDGG

\tFrame 3: YKKQKKEIKNE {STOP} YFFVREE {STOP} SR {STOP} SETQWYYHRF {STOP} VSNSGANNHSLKWLRCFY {STOP} RNRFRVQ {START} MARL {STOP} RFFQKGKTY {STOP} S {STOP} S {STOP} SFRS {STOP} KSGYHHCPNSIEAPLEE {STOP} TFANDCHRWCHRYWSAGWVRYCTKNRWSRFATDW {START} MGV"),
        
	'bio h '.$test_seq		=> test_zci("Help function activated. So this DDG Goodie does a couple of things:
	r		Reverse the sequence
	c		Complement the sequence
	rc		Reverse and complement the sequence
	tln		Translate the sequence in three frames using standard table
	#PLANNED	temp	Calculate a rough melting temperature for the sequence"),
	
	'bio herp derp'	=> test_zci("That sequence has non-\"AUCGT\" characters...?"),
	
	'bio herp'	=> test_zci("I don't see a function and sequence seperated by a space, like so: \"bio rc ATCG\", try again. Try \"bio h\" or \"bio help\" to get more possible functions.")
);

done_testing;
