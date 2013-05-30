%filename should be char, an epub file
%returns epubdata class

function data = load_data(filename)
    if ~exist(filename,'file')
        error('the file doesnot exist');
    end
    
    temp = 'temp';
    unzip(filename,temp);
    
    
    file = fullfile(temp,'content.opf');
    if exist(file, 'file') == 2
        xDoc = xmlread(file);
    else
        error('file doesnot exist');
    end
    %getting Metadata
    %metada load
    meta = xDoc.getElementsByTagName('metadata');
    if meta.getLength ~= 1
        error('Error in ePub file');
    end
    meta=meta.item(0);
    
    %extracting title of the book
    title = meta.getElementsByTagName('dc:title');
    if title.getLength() ~= 1
        error('Error in ePub File');
    end
    title = char(title.item(0).getTextContent);
    %extracting author of the book
    author = meta.getElementsByTagName('dc:creator');
    if author.getLength() ~= 1
        author = '';
    else
        author = char(author.item(0).getTextContent);
    end
    
    %foldername = [title ' - ' author];
    foldername = 'temp';
    %movefile(temp,foldername);
    
    %foldername = fullfile(foldername,temp);
    
    %Getting Manifest
    manifest = xDoc.getElementsByTagName('manifest').item(0);
    items = manifest.getElementsByTagName('item');
    
    %loading data from manifest
    j=1;
    for i=0:items.getLength()-1
       Data=items.item(i);
       type = char(Data.getAttribute('media-type'));
       if strcmp(type, 'application/xhtml+xml')
          hrefs(j) = Data.getAttribute('href');
          ids(j) = Data.getAttribute('id');
          j=j+1;
       end
    end
    hrefs=cell(hrefs);
    ids=cell(ids);
    
    %getting table of content
    tocfile=fullfile(foldername,'toc.ncx');
    if exist(tocfile,'file')
        tocfile = xmlread(tocfile);
        
        navMap = tocfile.getElementsByTagName('navMap').item(0);
        navPoints = navMap.getElementsByTagName('navPoint');
    
        for i=0:navPoints.getLength()-1
            navpoint=navPoints.item(i);
            table(i+1)=navpoint.getElementsByTagName('text').item(0).getTextContent;
            content(i+1)=navpoint.getElementsByTagName('content').item(0).getAttribute('src');
        end
    
        table=cell(table);
        content=cell(content);
    else
        table=[];
        content=[];
    end
    
    data = epubdata;
    data.foldername = foldername;
    fname = [title ' - ' author];
    fname = regexprep(fname,':', '_');
    
    data.filename = fname;
    data.title = title;
    data.author = author;
    data.hrefs = hrefs;
    data.ids = ids;
    data.table = table;
    data.content = content;
end