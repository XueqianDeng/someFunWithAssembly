/* CSF Assignment 2
 * Unit tests for hex functions
 * These tests should work for both your C implementations and your
 * assembly language implementations
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include <stdio.h>
#include <stdlib.h>
#include "tctest.h"
#include "hexfuncs.h"

// test fixture object
typedef struct {
  char test_data_1[16];
} TestObjs;

// setup function (to create the test fixture)
TestObjs *setup(void) {
  TestObjs *objs = malloc(sizeof(TestObjs));
  strcpy(objs->test_data_1, "Hello, world!\n");
  return objs;
}

// cleanup function (to destroy the test fixture)
void cleanup(TestObjs *objs) {
  free(objs);
}

// Prototypes for test functions
void test_format_offset(TestObjs *objs);
void test_format_byte_as_hex(TestObjs *objs);
void test_hex_to_printable(TestObjs *objs);
void test_hex_write_string(TestObjs *objs);
void test_hex_read(TestObjs *objs);

int main(int argc, char **argv) {
  if (argc > 1) {
    tctest_testname_to_execute = argv[1];
  }

  TEST_INIT();

  TEST(test_format_offset);
  TEST(test_format_byte_as_hex);
  TEST(test_hex_to_printable);
  TEST(test_hex_write_string);
  TEST(test_hex_read);
  
  TEST_FINI();

  return 0;
}

//test format offset
void test_format_offset(TestObjs *objs) {
  (void) objs; // suppress warning about unused parameter
  char buf[16];
  hex_format_offset(1U, buf);
  ASSERT(0 == strcmp(buf, "00000001"));
  
  char buf1[16]; 
  hex_format_offset(0x7b, buf1);
  ASSERT(0 == strcmp(buf1, "0000007b"));
  
  char buf2[16]; 
  hex_format_offset(0x20, buf2);
  ASSERT(0 == strcmp(buf2, "00000020"));
  
  char buf3[16]; 
  hex_format_offset(32, buf3);
  ASSERT(0 == strcmp(buf3, "00000020"));
  
  char buf4[16]; 
  hex_format_offset(48, buf4);
  ASSERT(0 == strcmp(buf4, "00000030"));
  
  char buf5[16]; 
  hex_format_offset(49, buf5);
  ASSERT(0 == strcmp(buf5, "00000031"));
  
  char buf6[16]; 
  hex_format_offset(1192722, buf6);
  ASSERT(0 == strcmp(buf6, "00123312"));

  char buf7[16]; 
  hex_format_offset(1192723, buf7);
  ASSERT(0 == strcmp(buf7, "00123313"));
  
  char buf8[16]; 
  hex_format_offset(1192724, buf8);
  ASSERT(0 == strcmp(buf8, "00123314"));
  
  char buf9[16]; 
  hex_format_offset(119223, buf9);
  ASSERT(0 == strcmp(buf9, "0001d1b7"));
  
  char buf10[16]; 
  hex_format_offset(4122232, buf10);
  ASSERT(0 == strcmp(buf10, "003ee678"));

  char buf11[16]; 
  hex_format_offset(18802296, buf11);
  ASSERT(0 == strcmp(buf11, "011ee678"));

  char buf12[16]; 
  hex_format_offset(16777215, buf12);
  ASSERT(0 == strcmp(buf12, "00ffffff"));

  char buf13[16]; 
  hex_format_offset(4294967295, buf13);
  ASSERT(0 == strcmp(buf13, "ffffffff"));

  char buf14[16]; 
  hex_format_offset(0U, buf14);
  ASSERT(0 == strcmp(buf14, "00000000"));

  char buf15[16]; 
  hex_format_offset(0x100000, buf15);
  ASSERT(0 == strcmp(buf15, "00100000"));

  char buf16[40]; 
  hex_format_offset(0xffffffff, buf16);
  ASSERT(0 == strcmp(buf16, "ffffffff"));

  char buf17[9]; 
  hex_format_offset(0x100000, buf17);
  ASSERT(0 == strcmp(buf17, "00100000"));

  char buf18[9]; 
  hex_format_offset(0xffffffff, buf18);
  ASSERT(0 == strcmp(buf18, "ffffffff"));

  char buf19[9]; 
  hex_format_offset(0x01010101, buf19);
  ASSERT(0 == strcmp(buf19, "01010101"));

  char buf20[9]; 
  hex_format_offset(0x0, buf20);
  ASSERT(0 == strcmp(buf20, "00000000"));


}

//test format as byte
void test_format_byte_as_hex(TestObjs *objs) {
  char buf[16];
  hex_format_byte_as_hex(objs->test_data_1[0], buf);
  ASSERT(0 == strcmp(buf, "48"));
  
  char buf1[16];
  hex_format_byte_as_hex(0x34, buf1);
  ASSERT(0 == strcmp(buf1, "34"));
  
  char buf2[16];
  hex_format_byte_as_hex(0x23, buf2);
  ASSERT(0 == strcmp(buf2, "23"));
  
  char buf3[16];
  hex_format_byte_as_hex(0x2b, buf3);
  ASSERT(0 == strcmp(buf3, "2b"));
  
  char buf4[16];
  hex_format_byte_as_hex(0x3c, buf4);
  ASSERT(0 == strcmp(buf4, "3c"));
  
  char buf5[16];
  hex_format_byte_as_hex(0xb1, buf5);
  ASSERT(0 == strcmp(buf5, "b1"));
  
  char buf6[10];
  hex_format_byte_as_hex(0x8c, buf6);
  ASSERT(0 == strcmp(buf6, "8c"));
  
  char buf7[16];
  hex_format_byte_as_hex(0xc3, buf7);
  ASSERT(0 == strcmp(buf7, "c3"));
  
  char buf8[16];
  hex_format_byte_as_hex(0xa3, buf8);
  ASSERT(0 == strcmp(buf8, "a3"));
  
  char buf0[16];
  hex_format_byte_as_hex(0x00, buf0);
  ASSERT(0 == strcmp(buf0, "00"));

  char buf9[3];
  hex_format_byte_as_hex(0xff, buf9);
  ASSERT(0 == strcmp(buf9, "ff"));

  char buf10[3];
  hex_format_byte_as_hex(0xf0, buf10);
  ASSERT(0 == strcmp(buf10, "f0"));

  char buf11[3];
  hex_format_byte_as_hex(0x10, buf11);
  ASSERT(0 == strcmp(buf11, "10"));

  char buf12[3];
  hex_format_byte_as_hex(0x01, buf12);
  ASSERT(0 == strcmp(buf12, "01"));
  
  char buf13[3];
  hex_format_byte_as_hex(0x7f, buf13);
  ASSERT(0 == strcmp(buf13, "7f"));
}

//test printable
void test_hex_to_printable(TestObjs *objs) {
  ASSERT('H' == hex_to_printable(objs->test_data_1[0]));
  ASSERT('.' == hex_to_printable(objs->test_data_1[13]));
  //this will test the unprintable range
  ASSERT(0x2E == hex_to_printable(10)); //newline ascii
  ASSERT(0x2E == hex_to_printable(0x05)); //EOF
  ASSERT(0x2E == hex_to_printable(0x00));
  ASSERT(0x2E == hex_to_printable(0x12));
  ASSERT(0x2E == hex_to_printable(0x11));
  ASSERT(0x2E == hex_to_printable(0x02));
  ASSERT(0x2E == hex_to_printable(0x13));
  ASSERT(0x2E == hex_to_printable(0x10));
  ASSERT(32 == hex_to_printable(32));
  ASSERT(0x31 == hex_to_printable(0x31));
  ASSERT(0x30 == hex_to_printable(0x30));
  ASSERT(0x2E == hex_to_printable(128));
  ASSERT(0x2E == hex_to_printable(131));
  ASSERT(0x2E == hex_to_printable(2));
  ASSERT(0x2E == hex_to_printable(127));
  ASSERT(0x2E == hex_to_printable(31)); // bound testing
  ASSERT(0x2E == hex_to_printable(27));
  //this will test the printable range
  ASSERT('S' == hex_to_printable('S'));
  ASSERT('b' == hex_to_printable('b'));
  ASSERT('p' == hex_to_printable('p'));
  ASSERT('&' == hex_to_printable('&'));
  ASSERT('*' == hex_to_printable('*'));
  ASSERT('2' == hex_to_printable('2'));
  ASSERT('1' == hex_to_printable('1'));
  ASSERT(';' == hex_to_printable(';'));
  ASSERT(']' == hex_to_printable(']'));
  ASSERT(' ' == hex_to_printable(' '));
  ASSERT('#' == hex_to_printable('#'));
  ASSERT('a' == hex_to_printable('a'));
  ASSERT('0' == hex_to_printable('0'));
  ASSERT('%' == hex_to_printable('%'));
  ASSERT('@' == hex_to_printable('@'));
  ASSERT('C' == hex_to_printable('C'));
  ASSERT('>' == hex_to_printable('>'));
  ASSERT('K' == hex_to_printable('K'));
  ASSERT('R' == hex_to_printable('R'));
  ASSERT(32 == hex_to_printable(32));
  ASSERT(126 == hex_to_printable(126));
}

//test hex_write
void test_hex_write_string(TestObjs *objs) {
  (void) objs; // suppress warning about unused parameter
  hex_write_string("Hello, World \n");
  hex_write_string("Yes, it's all right, this is a test for hex_write \n");
}

//test hex_read
void test_hex_read(TestObjs *objs) {
  (void) objs;
  hex_write_string("This is hex_read testing\n");
  hex_write_string("The program will once return everything(not too long) you type \n");
  char data_buffer[100] = {0};
  hex_read(data_buffer);
  hex_write_string(data_buffer);
}
