%filename should be char
function str_cat = html2text(filename)
    if ~exist(filename,'file')
       str_cat=NaN;
       return;
    end
    
    %{
    str_s = importdata(filename);
    str_cat = '';
    for i=1:length(str_s)
        str_cat = [str_cat ' ' char(str_s(i,:))];
    end
    %str_cat = strcat(str_s{:});
    %}
    
    str_cat = fileread(filename);
    
    index1=strfind(str_cat,'<body');
    index2=strfind(str_cat,'</body>');
    
    if isempty(index1) || isempty(index2)
        str_cat='';
        return;
    end
    
    str_cat = str_cat(index1:index2+6);
    
    
    str_cat = regexprep(str_cat,'â€™', '''');
    str_cat = regexprep(str_cat,'Â', '');
    str_cat = regexprep(str_cat,'â€?', '');
    str_cat = regexprep(str_cat,'â€œ', '');
    str_cat = regexprep(str_cat,'œ', '');
    str_cat = regexprep(str_cat,'?', '');
    
    str_cat = regexprep(str_cat,'<.*?>',' ');
    
    str_cat2 = str_cat;
    j=0;
    for i=1:length(str_cat)-1
        if ~(str_cat(i) == ' ' && str_cat(i+1) == ' ')
            j=j+1;
            str_cat2(j)=str_cat(i);
        end
    end
    
    str_cat=str_cat2(1:j);
    
end