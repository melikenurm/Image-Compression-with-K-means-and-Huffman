 % huffencode.m
   function bitstring = huffencode(input, table)

   bitstring = '';
   for l=1:length(input),
      bitstring = strcat(bitstring,table.code{strcmp(table.val,input{l})});
   end