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
  async (page: number = 1) => {  
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/user/list', {
      params: {
        page,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const createUserListAsync = createAsyncThunk(
  'user/create',
  async (user: any) => {
    const { name, username, password, role,phoneNumber,birtDay,address,email } = user;
    console.log(" user ", user);

    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/user/create', {
      name, username, password, role, phoneNumber,birtDay,address,email
    }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const deleteUserAsync = createAsyncThunk(
  'user/delete',
  async (id: number) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/user/delete', { id }, {
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
      }).addCase(createUserListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(createUserListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.userList = action.payload;
        state.user = action.payload;
      })
      .addCase(createUserListAsync.rejected, (state) => {
        state.status = 'failed';
      })

  },
});

export const getUserList = (state: RootState) => state.userState.userList;
export const getStatusUserState = (state: RootState) => state.userState.status;

export default TableSlice.reducer;
