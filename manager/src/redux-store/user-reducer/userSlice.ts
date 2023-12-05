import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { useState } from 'react';
import { api } from '../api';



export interface UserState {
  userList: any[];
  user: any;
  status: 'idle' | 'loading' | 'failed';
  numberStatus: number;
  errorMessage: string
}

const initialState: UserState = {
  userList: [],
  user: null,
  status: 'idle',
  numberStatus: 0,
  errorMessage: ''
};


export const getUserListAsync = createAsyncThunk(
  'user/get-list',
  async (page: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/user/list', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      params: {
        page: page,
      }
    });
    return response.data;
  }
);
export const createUserListAsync = createAsyncThunk(
  'user/create',
  async (user: any) => {

    const { idUser, name, username, password, roleUser, phoneNumber, email, address, birtDay, file } = user;


    const formData = new FormData();
    formData.append('idUser', idUser);
    formData.append('name', name);
    formData.append('username', username);
    formData.append('password', password);
    formData.append('role', roleUser);
    formData.append('phoneNumber', phoneNumber);
    formData.append('email', email);
    formData.append('address', address);
    formData.append('birtDay', birtDay);
    formData.append('file', file);

    try {
      const token = localStorage.getItem('token');
      const response = await axios.post(api + '/api/user/create', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ' + token,
        },
      });

      console.log('check log', response);
      return response.data;
    } catch (error: any) {
      const errResult = { error: true, message: error.response.data.message }
      return errResult;
    }
  }
);


export const deleteUserAsync = createAsyncThunk(
  'user/delete',
  async (id: any) => {
    const token = localStorage.getItem('token');
    console.log(" id ", id);

    const response = await axios.post(api + '/api/user/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const searchUserAsync = createAsyncThunk(
  'user/search-list',
  async (name: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/user/search', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      params: { name }
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
        const payload = action.payload;
        if (payload.error) {
          state.errorMessage = payload.message
        } else {
          state.errorMessage = '';
          state.userList = action.payload;
          state.user = action.payload;
        }
      })
      .addCase(createUserListAsync.rejected, (state, error) => {
        state.status = 'failed';
        console.log('111');

      }).addCase(deleteUserAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(deleteUserAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.userList = action.payload;
        state.user = action.payload;
      })
      .addCase(deleteUserAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(searchUserAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(searchUserAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.userList = action.payload;
      })
      .addCase(searchUserAsync.rejected, (state) => {
        state.status = 'failed';
      })
  },
});

export const getUserList = (state: RootState) => state.userState.userList;
export const getStatusUserState = (state: RootState) => state.userState.status;
export const getErrorMessage = (state: RootState) => state.userState.errorMessage;

export default TableSlice.reducer;