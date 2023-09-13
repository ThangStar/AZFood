import { createAsyncThunk, createSlice, PayloadAction } from '@reduxjs/toolkit';
import { RootState, AppThunk } from '@/redux-store/store';
import axios from 'axios';

export interface AuthenticationState {
  jwtToken: any;
  username: any;
  userID: any;
  status: 'loading' | 'failed' | 'success';
  error : any
}

const initialState: AuthenticationState = {
    jwtToken: null,
    username: null,
    userID: null,
    status: 'success',
    error : ""
};

export const loginAsync = createAsyncThunk(
  'authentication/login',
  async (account: any) => {
    const response = await axios.post('http://localhost:8080/api/user/login', {username: account.username, password: account.password})
    console.log("response " ,response.data);
    
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
        state.userID = action.payload.id;
      })
      .addCase(loginAsync.rejected, (state, error) => {
        state.status = 'failed';
        state.error = error
      });
  },
});

export const getJWTToken = (state: RootState) => state.authenticationState.jwtToken;
export const getUserFullname = (state: RootState) => state.authenticationState.username;
export const getUserID = (state: RootState) => state.authenticationState.userID;

export default counterSlice.reducer;