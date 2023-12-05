import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, api } from '../store';



export interface TopProductState {
  topMenuList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: TopProductState = {
  topMenuList: [],
  status: 'idle',
};

export const getTopMenuListAsync = createAsyncThunk(
  'top-menu/get-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/products/listTopProduct', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    })
    return response.data
  }
)

const topMenuSlice = createSlice({
  name: 'top-menu',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(getTopMenuListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.topMenuList = action.payload;
      })
      .addCase(getTopMenuListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getTopMenuListAsync.rejected, (state) => {
        state.status = 'failed';
      })
  },
})

export const getTopMenuList = (state: RootState) => state.topMenuState.topMenuList

export default topMenuSlice.reducer;
