%container for epub metadata
%hrefs to contents are cell data sturcture

classdef epubdata
   properties
      foldername = '';
      filename = '';
      title = '';
      author = '';
      hrefs;
      ids;
      table;
      content;
   end
end