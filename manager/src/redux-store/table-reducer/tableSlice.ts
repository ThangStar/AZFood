import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface TableState {
  tableList: any[];
  tableStatusList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: TableState = {
  tableList: [],
  tableStatusList: [],
  status: 'idle',
};

export const getTableListAsync = createAsyncThunk(
  'table/get-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/table/list', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const createTableListAsync = createAsyncThunk(
  'table/create',
  async (name: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/table/create', name, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const getStatusTableAsync = createAsyncThunk(
  'table/get-status',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/table/listStatus', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const updateStatusTableAsync = createAsyncThunk(
  'table/update-status',
  async ({ status, id }: { status: number, id: number }) => {
    const token = localStorage.getItem('token');

    const response = await axios.post(serverUrl + '/api/table/updateStatus', { status, id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const deleteTableAsync = createAsyncThunk(
  'table/delete',
  async (id: number) => {
    const token = localStorage.getItem('token');

    const response = await axios.post(serverUrl + '/api/table/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
const TableSlice = createSlice({
  name: 'table',
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    builder
      .addCase(getTableListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getTableListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.tableList = action.payload;
      })
      .addCase(getTableListAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(createTableListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(createTableListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.tableList = action.payload;
      })
      .addCase(createTableListAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(getStatusTableAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getStatusTableAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.tableStatusList = action.payload;
      })
      .addCase(getStatusTableAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(updateStatusTableAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(updateStatusTableAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.tableList = action.payload;
      })
      .addCase(updateStatusTableAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(deleteTableAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(deleteTableAsync.fulfilled, (state, action) => {
        state.status = 'idle';
      })
      .addCase(deleteTableAsync.rejected, (state) => {
        state.status = 'failed';
      })
  },
});

export const getTableList = (state: RootState) => state.tableState.tableList;
export const getTableStatusList = (state: RootState) => state.tableState.tableStatusList;

export default TableSlice.reducer;
