function [data_splited] = split_data_in_epochs(raw_data, epochs_str, qnt_epochs, epoch_duration, fs)
%SPLIT_DATA_IN_EPOCHS Summary of this function goes here
%   Detailed explanation goes here
epoch_seconds = convert_str_time_vector_to_seconds(epochs_str, qnt_epochs);
data_splited = zeros(qnt_epochs, epoch_duration * fs + 1);
for ii=1:qnt_epochs
    index_start = epoch_seconds(ii)*fs;
    index_end = (epoch_seconds(ii) + epoch_duration)*fs;
    data_splited(ii,:) = raw_data(1, index_start:index_end);
end
end

function [seconds_time_vector] = convert_str_time_vector_to_seconds(str_time_vector, qnt_times)
%SPLIT_DATA_IN_EPOCHS Summary of this function goes here
%   Detailed explanation goes here
seconds_time_vector = zeros(1, qnt_times);
for ii=1:qnt_times
    time_aux = split(str_time_vector(ii, :),':');
    seconds_time_vector(ii) = str2double(time_aux{1}) * 60 + str2double(time_aux{2});
end
end
