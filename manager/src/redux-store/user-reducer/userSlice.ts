import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface UserState {
  userList: any[];
  user: any;
  status: 'idle' | 'loading' | 'failed';
}

const initialState: UserState = {
    userList: [],
    user: null,
  status: 'idle',
};

export const getUserListAsync = createAsyncThunk(
  'user/get-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/user/list', {
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
      .addCase(getUserListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getUserListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.userList = action.payload;
      })
      .addCase(getUserListAsync.rejected, (state) => {
        state.status = 'failed';
      })
      
  },
});

export const getUserList = (state: RootState) => state.userState.userList;

export default TableSlice.reducer;
