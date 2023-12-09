import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { api } from '../api';



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
    const { userID, tableID, productID, quantity, category, price } = data;

    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/create', { userID, tableID, productID, quantity, category, price }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const incrementProductAsync = createAsyncThunk(
  'order/increment',
  async (data: any) => {
    const { quantity, productID } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/increment', { quantity, productID }, {
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
    const { userID, tableID, productID, quantity, category } = data;


    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/update', { orderID, userID, tableID, productID, quantity, category }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const updatePriceOrderAsync = createAsyncThunk(
  'order/update-price',
  async ({ data }: { data: any }) => {
    const { id, subTotal } = data;
    console.log(" id", id);
    console.log("subTotal ", subTotal);


    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/updatePriceItem', { subTotal, id }, {
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
    const response = await axios.get(api + '/api/orders/list', {
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
    const response = await axios.post(api + '/api/orders/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const deleteAllOrderAsync = createAsyncThunk(
  'order/deleteAll',
  async (id: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/deleteAll', { id }, {
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
  async (data: any) => {
    console.log("data", data);

    const { id, payMethod } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/orders/payBill', { id, payMethod }, {
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
      const response = await axios.get(api + `/api/orders/getOrder`, {
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


      .addCase(incrementProductAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(incrementProductAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(incrementProductAsync.rejected, (state) => {
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
      }).addCase(updatePriceOrderAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(updatePriceOrderAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.orderList = action.payload;
      })
      .addCase(updatePriceOrderAsync.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const getOrderList = (state: RootState) => state.orderState.orderList;
export const getOrder = (state: RootState) => state.orderState.order;
export const getStatus = (state: RootState) => state.orderState.status;

export default OrderSlice.reducer;
