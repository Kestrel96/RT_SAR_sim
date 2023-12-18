function normalized= dbn(x)
%DBN Get normalized db output. Use with clim[] when displaying a figure.
%   Thanks to Maciej Wilego for suggestion.
normalized = db(x)-max(db(x),[],"all");
end

