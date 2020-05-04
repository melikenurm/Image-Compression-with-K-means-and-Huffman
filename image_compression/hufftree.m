% hufftree.m
   function [tree, table] = hufftree(alphabet,prob)

   for l=1:length(alphabet)% her renk için bir yaprak oluþturulur
      leaves(l).val = alphabet{l};
      leaves(l).zero= '';
      leaves(l).one='';
      leaves(l).prob = prob(l);
   end

   % en düþük olasýlýklý 2 renk toplanarak baþlanýr
   % tek düðüm kalana kadar devam edilir
   while length(leaves)>1                           
      [dummy,I]=sort(prob);                         
      prob = [prob(I(1))+prob(I(2)) prob(I(3:end))];
      node.zero = leaves(I(1));         
      node.one  = leaves(I(2));         
      node.prob = prob(1);
      node.val = '';
      leaves = [node leaves(I(3:end))];
   end


   % dfs ile her renge karþýlýk gelen kodlarýn tutulduðu tablo oluþturulur
   table.val={}; table.code={};
   [tree, table] = descend(leaves(1),table,'');


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   function [tree, table] = descend(oldtree, oldtable, code)

   table = oldtable;
   if(~isempty(oldtree.val))
      tree.val = oldtree.val;
      table.val{end+1}  = oldtree.val;
      table.code{end+1} = code;
   else
      [tree0, table] = descend(oldtree.zero, table, strcat(code,'0'));
      [tree1, table] = descend(oldtree.one,  table, strcat(code,'1'));
      tree.zero=tree0;
      tree.one= tree1;
   end
  