function textfile = epub2text(filename)
    if ~exist(filename,'file')
        error('the file doesnot exist');
    end
    
    epub = load_data(filename);
    
    N = length(epub.hrefs);
    
    textfile = [epub.filename '.txt'];
    file = fopen(textfile, 'w');
    for i=1:N
        fname = fullfile(epub.foldername, char(epub.hrefs(i)));
        str_cat = html2text(fname);
        str_cat(length(str_cat)+1) = '.';
        fprintf(file,'%s',str_cat);
    end
    fclose(file)
    
    rmdir(epub.foldername, 'S');
end