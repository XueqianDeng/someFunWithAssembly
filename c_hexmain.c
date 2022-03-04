/* CSF Assignment 2
 * C implementation of hexdump main function
 * Harry Yu cyu62@jhu.edu
 * Xueqian Deng xdeng13@jhu.edu
 */

#include "hexfuncs.h"  // this is the only header file which may be included!

int main(void) {
  char data_buffer[17]; // this string to keep input data
  int counter = 0;
  unsigned offset_counter = 0; //number of hexidecimal offset
  
  do{
    counter = hex_read(data_buffer);
    if (counter == 0){ //if empty file from the start
      break;
    }
    // note: up to requirements, the program runs only one time, instead runnning
    // until CTRL^D; until it reaches the end of statement.
    char offset_keeper[16];
    hex_format_offset(offset_counter, offset_keeper);
    // hexidecimal offset is translated into offsetkeeper
    hex_write_string(offset_keeper);
    // let's ouput the first 8 hex  
    hex_write_string(": ");

    // column and space before the ASCII code for each char
    char *data_buffer_hex_extractor1 = data_buffer; // hex char counter
    int position = 0; // there are case that the line is not full.
    for (; position < counter; position++) {
      unsigned char byte_val = *data_buffer_hex_extractor1;
      data_buffer_hex_extractor1++;
      // this shoud take out the character byte
      char byte_val_keep[2];
      // bytevalkeep is to keep the two bytes
      hex_format_byte_as_hex(byte_val, byte_val_keep);
      hex_write_string(byte_val_keep);
      hex_write_string(" ");
      // this would print out the hex char of the character
    }
    // this for loop will write the hex char
    for(; position < 16; position++) {
      hex_write_string("   ");
    }
    // this is to make up the space if there is no 16 byte to write in the line
    hex_write_string(" ");
    // this is the end of writing hex char
    for(int i=0; i < counter; i++) {
      data_buffer[i] = hex_to_printable(data_buffer[i]);
      //this should output the character if printable
    }
    data_buffer[counter] = '\0';
    hex_write_string(data_buffer);
    hex_write_string("\n");
    // everytime there should be exact 16 read-in, unless the line ends 
    offset_counter += 16;
  }while (counter == 16);
  // I believe we are all set with this while loop
}
