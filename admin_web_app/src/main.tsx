import { CssBaseline, ThemeProvider } from '@mui/material'
import React from 'react'
import ReactDOM from 'react-dom/client'
import { Provider } from 'react-redux'
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import App from './App'


import { store } from './store/store'
import { theme } from './theme'
import Login from './views/auth/login/login'
import Dashboard from './views/dashboard/dashboard'
import QuestionList from './views/question/QuestionList'
import UserList from './views/user/view/UserList'
import ModeOneList from './views/mode_one/ModeOneList'
import ModeTwoList from './views/mode_two/ModeTwoList'
import ModeThreeList from './views/mode_three/ModeThreeList'
import ModeFourList from './views/mode_four/ModeFourList'

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Provider store={store}>
        <BrowserRouter>
          <App>
            <Routes>
              <Route path="/mode-one" element={<ModeOneList />} />
              <Route path="/mode-two" element={<ModeTwoList />} />
              <Route path="/mode-three" element={<ModeThreeList />} />
              <Route path="/mode-four" element={<ModeFourList />} />
              <Route path="/users" element={<UserList />} />
              <Route path="/questions" element={<QuestionList />} />
              <Route path="/login" element={<Login />} />
              <Route path='*' element={<Dashboard />} />
            </Routes>
          </App>
        </BrowserRouter>
      </Provider>
    </ThemeProvider>
  </React.StrictMode>,
)
