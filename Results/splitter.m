function header = splitter(filename)
% Nomenclature
            split = strsplit(filename,'_');
            % 4 parameter: noVolume term = G, kein radius control (wäre para 6)
            if length(split) == 4
                % Volume normalized 
                if split(4) == "NGPCA" || split(4) == "Migenda"
                    header = "N0-G";
                else
                    header = "N1-G";
                end
                % Volume controlled
                if split(4) == "NGPCA" || split(4) == "Hoffmann"
                    header = append(header, "-N");
                else
                    header = append(header, "-V");
                end
                % soft vs hard clustering
                if split(3) == "soft"
                    header = append(header, "-S");
                else
                    header = append(header, "-H");
                end
                % Variance vs Gaussian learning rate
                if split(2) == "Variance"
                    header = append(header, "-V");
                else
                    header = append(header, "-G");
                end
            elseif length(split) == 5
                % Volume normalized 
                if split(4) == "NGPCA" || split(4) == "Migenda"
                    header = "N0";
                else
                    header = "N1";
                end
                if split(5) == "withVolume"
                    header = append(header, "-M");
                else
                    header = append(header, "-G");
                end
                % Volume controlled
                if split(4) == "NGPCA" || split(4) == "Hoffmann"
                    header = append(header, "-N");
                elseif split(5) == "radius"
                    header = append(header, "-R");
                else
                    header = append(header, "-V");
                end
                % soft vs hard clustering
                if split(3) == "soft"
                    header = append(header, "-S");
                else
                    header = append(header, "-H");
                end
                % Variance vs Gaussian learning rate
                if split(2) == "Variance"
                    header = append(header, "-V");
                else
                    header = append(header, "-G");
                end
                
            elseif length(split) == 6
                % Volume normalized 
                if split(4) == "NGPCA" || split(4) == "Migenda"
                    header = "N0-M-R";
                else
                    header = "N1-M-R";
                end
                % soft vs hard clustering
                if split(3) == "soft"
                    header = append(header, "-S");
                else
                    header = append(header, "-H");
                end
                % Variance vs Gaussian learning rate
                if split(2) == "Variance"
                    header = append(header, "-V");
                else
                    header = append(header, "-G");
                end
            end
end

