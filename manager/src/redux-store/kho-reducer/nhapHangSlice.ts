import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { useLayoutEffect } from 'react';
import { api } from '../api';



export interface MenuItemState {
  nhapHangList: any[];
  ProductList: any[];
  dvtList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: MenuItemState = {
  nhapHangList: [],
  ProductList: [],
  dvtList: [],
  status: 'idle',
};

export const getPhieuNhapListAsync = createAsyncThunk(
  'nhapHang/get-list',
  async () => {
    const token = localStorage.getItem('token');

    const response = await axios.get(api + '/api/kho/list', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const getDvtListAsync = createAsyncThunk(
  'nhapHang/list-dvt',
  async () => {
    const token = localStorage.getItem('token');

    const response = await axios.get(api + '/api/products/listDVT', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const getProductListAsync = createAsyncThunk(
  'nhapHang/list-product',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/kho/products', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const nhapHangAsync = createAsyncThunk(
  'nhapHang/create',
  async (data: any) => {
    const { productID, soLuong, donGia, dvtID } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/kho/create',
      {
        productID,
        soLuong,
        donGia,
        dvtID
      }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
const nhapHangSlice = createSlice({
  name: 'menuItem',
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    builder
      .addCase(getPhieuNhapListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getPhieuNhapListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.nhapHangList = action.payload;
      })
      .addCase(getPhieuNhapListAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(nhapHangAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(nhapHangAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.nhapHangList = action.payload;
      })
      .addCase(nhapHangAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(getDvtListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getDvtListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.dvtList = action.payload;
      })
      .addCase(getDvtListAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(getProductListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.ProductList = action.payload;
      }).addCase(getProductListAsync.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const getPhieuNhapList = (state: RootState) => state.nhapHangState.nhapHangList;
export const getDVTList = (state: RootState) => state.nhapHangState.dvtList;
export const getProductList = (state: RootState) => state.nhapHangState.ProductList;
export const getProductState = (state: RootState) => state.userState.status;

export default nhapHangSlice.reducer;
