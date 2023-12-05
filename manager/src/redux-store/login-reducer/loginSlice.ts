import { createAsyncThunk, createSlice, PayloadAction } from '@reduxjs/toolkit';
import { RootState, AppThunk } from '@/redux-store/store';
import axios from 'axios';
import { api } from '../api';

export interface AuthenticationState {
  jwtToken: any;
  username: any;
  userID: any;
  role: any;
  status: 'loading' | 'failed' | 'success';
  error: any
}

const initialState: AuthenticationState = {
  jwtToken: null,
  username: null,
  userID: null,
  role: null,
  status: 'success',
  error: ""
};

export const loginAsync = createAsyncThunk(
  'authentication/login',
  async (account: any) => {
    const response = await axios.post(api + '/api/user/login', { username: account.username, password: account.password })
    console.log("response ", response.data);

    return response.data;
  }
);

export const changePassAsync = createAsyncThunk(
  'authentication/changePassword',
  async (payload: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/user/change', { oldPassword: payload.oldPassword, password: payload.password }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    })
    return response.data;
  }
);

export const counterSlice = createSlice({
  name: 'authentication',
  initialState,
  reducers: {

  },
  extraReducers: (builder) => {
    builder
      .addCase(loginAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(loginAsync.fulfilled, (state, action) => {
        state.status = 'success';
        state.jwtToken = action.payload.jwtToken;
        state.username = action.payload.username;
        state.role = action.payload.role;
        state.userID = action.payload.id;
      })
      .addCase(loginAsync.rejected, (state, error) => {
        state.status = 'failed';
        state.error = error
      })
      .addCase(changePassAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(changePassAsync.fulfilled, (state, action) => {
        state.status = 'success';
        console.log(action.payload)
      })
      .addCase(changePassAsync.rejected, (state, error) => {
        state.status = 'failed';
        state.error = error
      })
  },
});

export const getJWTToken = (state: RootState) => state.authenticationState.jwtToken;
export const getUserFullname = (state: RootState) => state.authenticationState.username;
export const getUserID = (state: RootState) => state.authenticationState.userID;
export const getRole = (state: RootState) => state.authenticationState.role;

export default counterSlice.reducer;