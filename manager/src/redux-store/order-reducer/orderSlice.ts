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
export const createOrderAsync = createAsyncThunk(
  'order/create',
  async (data: any) => {
    const { userID, tableID, productID, quantity } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/orders/create', { userID, tableID, productID, quantity }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const updateOrderAsync = createAsyncThunk(
  'order/update',
  async ({ data, orderID }: { data: any; orderID: any }) => {
    const { userID, tableID, productID, quantity } = data;
    console.log("data redux :", data);
    console.log("orderID redux :", orderID);

    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/orders/update', { orderID, userID, tableID, productID, quantity }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
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
export const deleteOrderAsync = createAsyncThunk(
  'order/delete',
  async (id: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/orders/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const payBillAsync = createAsyncThunk(
  'order/payBill',
  async (id: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/orders/payBill', { id }, {
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
      .addCase(payBillAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(updateOrderAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(deleteOrderAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(deleteOrderAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(deleteOrderAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(createOrderAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(createOrderAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(createOrderAsync.rejected, (state) => {
        state.status = 'failed';
      })
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
export const getStatus = (state: RootState) => state.orderState.status;

export default OrderSlice.reducer;
