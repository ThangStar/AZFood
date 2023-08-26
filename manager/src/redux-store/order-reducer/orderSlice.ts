import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface TableState {
  orderList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: TableState = {
    orderList: [],
  status: 'idle',
};

export const getOrderListAsync = createAsyncThunk(
  'order/get-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/orders/list', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

const OrderSlice = createSlice({
  name: 'orders',
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    builder
      .addCase(getOrderListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getOrderListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(getOrderListAsync.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const getOrderList = (state: RootState) => state.orderState.orderList;

export default OrderSlice.reducer;
