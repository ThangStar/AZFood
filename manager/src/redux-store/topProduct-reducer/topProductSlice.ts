import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { api } from '../api';



export interface TopProductState {
  topMenuList: any[];
  reportDayList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: TopProductState = {
  topMenuList: [],
  reportDayList: [],
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

export const getReportDayListAsync = createAsyncThunk(
  'top-menu/report-day',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/invoice/report-day', { day: 30, month: 10 }, {
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
      .addCase(getReportDayListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.reportDayList = action.payload;
      })
      .addCase(getReportDayListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getReportDayListAsync.rejected, (state) => {
        state.status = 'failed';
      })
  },
})

export const getTopMenuList = (state: RootState) => state.topMenuState.topMenuList
export const getReportDayList = (state: RootState) => state.topMenuState.reportDayList

export default topMenuSlice.reducer;
