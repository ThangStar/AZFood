import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, api } from '../store';
import { useLayoutEffect } from 'react';

const serverUrl = api;

export interface MenuItemState {
  menuItemList: any[];
  menuList: any[];
  categoryList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: MenuItemState = {
  menuItemList: [],
  menuList: [],
  categoryList: [],
  status: 'idle',
};

export const getMenuItemListAsync = createAsyncThunk(
  'menuItem/get-list',
  async (page: number = 1) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/products/list', {
      params: {
        page,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const getSearchMenuListAsync = createAsyncThunk(
  'menuItem/search-list',
  async (name: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/products/searchProducts', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      params: { name }
    });
    return response.data;
  }
);

export const getFilterCategoryListAsync = createAsyncThunk(
  'menuItem/filter-category',
  async (category: any) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/products/filterData', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      params: { category }
    });
    return response.data;
  }
);

export const createMenuItemAsync = createAsyncThunk(
  'product/create',
  async (data: any) => {
    const { dvtID, name, price, category, status, id, file, quantity } = data;

    const formData = new FormData();
    formData.append('name', name);
    formData.append('price', price);
    formData.append('category', category);
    formData.append('status', status);
    formData.append('id', id);
    formData.append('file', file);
    formData.append('dvtID', dvtID);
    formData.append('quantity', quantity);

    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/products/create', { dvtID, name, price, category, status, id, file, quantity }, {
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const getCategoryListAsync = createAsyncThunk(
  'category/get-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/products/category', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const deleteMenuItemAsync = createAsyncThunk(
  'product/delete',
  async (id: any) => {
    console.log("id", id);

    const token = localStorage.getItem('token');
    const response = await axios.post(serverUrl + '/api/products/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const getMenuListAsync = createAsyncThunk(
  'menuItem/get-list-all',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(serverUrl + '/api/products/listAll', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });

    return response.data;
  }
);

export const updateStatusMenuItem = createAsyncThunk(
  'menuItem/update-status',
  async (data: any) => {
    const token = localStorage.getItem('token')
    const { id, status } = data
    const response = await axios.post(serverUrl + '/api/products/updateStatus', { id, status }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    })
    return response.data
  })
const menuItemSlice = createSlice({
  name: 'menuItem',
  initialState,
  reducers: {},

  extraReducers: (builder) => {
    builder
      .addCase(getMenuListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuList = action.payload;
      })
      .addCase(getMenuItemListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getMenuItemListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
      })
      .addCase(getMenuItemListAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(getCategoryListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getCategoryListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.categoryList = action.payload;
      })
      .addCase(getCategoryListAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(createMenuItemAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(createMenuItemAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
      })
      .addCase(createMenuItemAsync.rejected, (state) => {
        state.status = 'failed';
      }).addCase(deleteMenuItemAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(deleteMenuItemAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
      })
      .addCase(deleteMenuItemAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(getSearchMenuListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getSearchMenuListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
        state.menuList = action.payload;
      })
      .addCase(getSearchMenuListAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(getFilterCategoryListAsync.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(getFilterCategoryListAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.menuItemList = action.payload;
        state.menuList = action.payload;
      })
      .addCase(getFilterCategoryListAsync.rejected, (state) => {
        state.status = 'failed';
      })
      .addCase(updateStatusMenuItem.pending, (state) => {
        state.status = 'loading'
      })
      .addCase(updateStatusMenuItem.fulfilled, (state, action) => {
        state.status = 'idle'
        console.log(action.payload)
      })
      .addCase(updateStatusMenuItem.rejected, (state) => {
        state.status = 'failed'
      })
  },
});

export const getMenuItemtList = (state: RootState) => state.menuItemState.menuItemList;
export const getItemtList = (state: RootState) => state.menuItemState.menuList;
export const getCategoryList = (state: RootState) => state.menuItemState.categoryList;

export default menuItemSlice.reducer;
