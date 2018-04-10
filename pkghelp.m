% Script to display functions and help on functions for a package
% published by Georg W. on Stackoverflow.com
% https://stackoverflow.com/questions/13645767/how-to-obtain-list-of-functions-of-a-package-that-is-installed-in-octave#answer-46811147
function pkghelp(pkgname)

  % Get functions for this package
   des = pkg('describe','-verbose',pkgname);
   % Get first element
   des = des{1};

   if isempty(des)
     error('pkghelp:unknownPackage','Package "%s" was not found!',pkgname);
   endif

   % Create a dialog with functions
   pname = des.name;
   pvers = des.version;
   pdesc = des.description;

   % Number of categories
   ncat = numel(des.provides);
   list = cell(1,1);
   cnt=1;
   for i=1:ncat
     % Store category name
     list(cnt) = ['--(* ',des.provides{i}.category,' *)--'];
     % Number of functions
     nfunc = numel(des.provides{i}.functions);
     % Append functions in category
     list(cnt+1:cnt+nfunc) = des.provides{i}.functions(:);
     % Update counter
     cnt = cnt+1+nfunc;
   endfor

  ok=1;
  while ok==1  
    % Create dialog
    [sel, ok] = listdlg ('ListString', list,...
                     'SelectionMode', 'Single', ...
                     'ListSize',[300,600],...
                     'Name',pname,...
                     'PromptString','List of available functions');


    if (ok==1)
     % Selected function name
     selfun = list{sel};
     % Not a category?
     if selfun(1) ~= '-'
       % assure that package is loaded for help
       pkg('load',pkgname);
       % Get help text for selected function
       doc = help(selfun);
       % Open dialog with help text display
       msgbox(doc,[pname,'/',selfun],'help');
     endif
    endif
  endwhile

endfunction