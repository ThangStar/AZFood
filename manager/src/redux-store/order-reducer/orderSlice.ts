import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';

const serverUrl = "http://localhost:8080";

export interface TableState {
  orderList: any[];
  order: any,
  status: 'idle' | 'loading' | 'failed';
}

const initialState: TableState = {
  orderList: [],
  order: null,
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
export const getOrderInTableListAsync = createAsyncThunk(
  'order/get-order',

  async (tableID: any) => {
    try {
      console.log(" tableID", tableID);
      const token = localStorage.getItem('token');
      const response = await axios.get(serverUrl + `/api/orders/getOrder`, {
        params: { tableID },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token,
        }
      });
      return response.data;
    } catch (error) {
      console.log(" error", error);
    }

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
      }).addCase(getOrderInTableListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getOrderInTableListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.order = action.payload;
      })
      .addCase(getOrderInTableListAsync.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const getOrderList = (state: RootState) => state.orderState.orderList;
export const getOrder = (state: RootState) => state.orderState.order;

export default OrderSlice.reducer;
