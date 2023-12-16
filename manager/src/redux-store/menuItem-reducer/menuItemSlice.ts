import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import axios from 'axios';
import { RootState, } from '../store';
import { api } from '../api';

export interface MenuItemState {
  menuItemList: any[];
  menuList: any[];
  categoryList: any[];
  priceList: any[];
  sizeList: any[];
  status: 'idle' | 'loading' | 'failed';
}

const initialState: MenuItemState = {
  menuItemList: [],
  sizeList: [],
  menuList: [],
  categoryList: [],
  status: 'idle',
  priceList: [],
};

export const getMenuItemListAsync = createAsyncThunk(
  'menuItem/get-list',
  async (page: number = 1) => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/products/list', {
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
    const response = await axios.get(api + '/api/products/searchProducts', {
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
    const response = await axios.get(api + '/api/products/filterData', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
      params: { category }
    });
    return response.data;
  }
);
export const getPriceForSize = createAsyncThunk(
  'menuItem/price-list',
  async () => {
    const token = localStorage.getItem('token');
    const response = await axios.get(api + '/api/products/listPriceProduct', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
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
    const response = await axios.post(api + '/api/products/create', { dvtID, name, price, category, status, id, file, quantity }, {
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);

export const createPriceForProdAsync = createAsyncThunk(
  'price/create',
  async (data: any) => {
    const { productID, sizeValue, prodPrice, size } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/products/createPrice',
      {
        productID, sizeValue, prodPrice, size
      }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const updatePriceForProdAsync = createAsyncThunk(
  'price/update',
  async (data: any) => {
    const { productID, sizeValue, prodPrice, id } = data;
    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/products/updatePrice',
      {
        productID, sizeValue, prodPrice, id
      }, {
      headers: {
        'Content-Type': 'application/json',
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
    const response = await axios.get(api + '/api/products/category', {
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
    const response = await axios.post(api + '/api/products/delete', { id }, {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });
    return response.data;
  }
);
export const deletePriceAsync = createAsyncThunk(
  'price/delete',
  async (id: any) => {
    console.log("id", id);

    const token = localStorage.getItem('token');
    const response = await axios.post(api + '/api/products/deletePrice', { id }, {
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
    const response = await axios.get(api + '/api/products/listAll', {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      },
    });

    return response.data;
  }
);
export const getSizeListAsync = createAsyncThunk(
  'menuItem/get-list-size',
  async () => {
    const token = localStorage.getItem('token')
    const response = await axios.get(api + '/api/products/listProductSize', {
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
    const response = await axios.post(api + '/api/products/updateStatus', { id, status }, {
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
      .addCase(getPriceForSize.pending, (state) => {
        state.status = 'loading'
      })
      .addCase(getPriceForSize.fulfilled, (state, action) => {
        state.status = 'idle',
          state.priceList = action.payload;
      })
      .addCase(getPriceForSize.rejected, (state) => {
        state.status = 'failed'
      }).addCase(deletePriceAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.priceList = action.payload;
      }).addCase(createPriceForProdAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.priceList = action.payload;
      }).addCase(updatePriceForProdAsync.fulfilled, (state, action) => {
        state.status = 'idle';
        state.priceList = action.payload;
      }).addCase(getSizeListAsync.fulfilled, (state, action) => {
        state.sizeList = action.payload;
        state.status = 'idle'
      })
  },
});

export const getMenuItemtList = (state: RootState) => state.menuItemState.menuItemList;
export const getItemtList = (state: RootState) => state.menuItemState.menuList;
export const getCategoryList = (state: RootState) => state.menuItemState.categoryList;
export const getPriceList = (state: RootState) => state.menuItemState.priceList;
export const getSizeList = (state: RootState) => state.menuItemState.sizeList;

export default menuItemSlice.reducer;
