import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState } from '../store';
import { useLayoutEffect } from 'react';

const serverUrl = "http://localhost:8080";

export interface MenuItemState {
  menuItemList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: MenuItemState = {
  menuItemList: [],
  status: 'idle',
};

export const getMenuItemListAsync = createAsyncThunk(
  'menuItem/get-list',
  async () => {
    const token = localStorage.getItem('token');
    console.log('get token', token);
    const response = await axios.get(serverUrl + '/api/products/list', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

const menuItemSlice = createSlice({
  name: 'menuItem',
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    builder
      .addCase(getMenuItemListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getMenuItemListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
      })
      .addCase(getMenuItemListAsync.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const getMenuItemtList = (state: RootState) =>
  state.menuItemState.menuItemList;

export default menuItemSlice.reducer;
