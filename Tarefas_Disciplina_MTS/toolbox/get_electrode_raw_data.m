function [target_raw_data] = get_electrode_raw_data(nome_electrode, eeg_complete, canal_names)
%GET_ELECTRODE Summary of this function goes here
%   Detailed explanation goes here
index_aux = strfind(canal_names, nome_electrode);
index_target = find(not(cellfun('isempty', index_aux)));
target_raw_data = eeg_complete(index_target, :);
end

