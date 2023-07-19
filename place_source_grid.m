function [grid_source, sourcedata] = place_source_on_grid(source_mask, array_columns, array_rows, spacing_columns, spacing_rows, size_column_dim, size_row_dim, kgrid, x_pos)
    % Place the source on the grid.
    % Render the source mask on the grid,
    % considering the grid spacing units.
    % Parameters:
    %     grid (kWaveGrid): The k-Wave grid.
    %     x_pos (int): The x position of the source in the YZ plane.

    grid_source = zeros(kgrid.N);
    col_size = array_columns * size_column_dim + (array_columns - 1) * spacing_columns;
    row_size = array_rows * size_row_dim + (array_rows - 1) * spacing_rows;
    sourcedata = zeros(row_size, col_size);

    % expand the source mask into the size of the grid, including spacing elements
    for k = 1:array_columns
        for l = 1:array_rows
            sourcedata((l - 1) * (size_row_dim + spacing_rows) + 1:l * (size_row_dim + spacing_rows), ...
                (k - 1) * (size_column_dim + spacing_columns) + 1:k * (size_column_dim + spacing_columns)) = source_mask(l, k);
        end
    end

    % place the source mask on the grid
    grid_source(x_pos, ...
        int32(kgrid.Ny/2) - int32(floor(size(sourcedata, 1)/2)):int32(kgrid.Ny/2 - floor(size(sourcedata, 1)/2)) + size(sourcedata, 1)-1 , ...
        int32(kgrid.Nz/2) - int32(floor(size(sourcedata, 2)/2)):int32(kgrid.Nz/2 - floor(size(sourcedata, 2)/2)) + size(sourcedata, 2)-1) = sourcedata;

    % source_data = sourcedat
end