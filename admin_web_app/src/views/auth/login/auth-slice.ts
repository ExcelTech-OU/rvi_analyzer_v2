import { createSlice } from '@reduxjs/toolkit'
import type { PayloadAction } from '@reduxjs/toolkit'
import { LoginResponse, SimpleUser } from '../../../services/login_service'

interface LoginSlice {
    simpleUser: SimpleUser | null
    jwt: string | null
}

const initialState: LoginSlice = {
    simpleUser: null,
    jwt: null
}

export const loginSlice = createSlice({
    name: 'login',
    initialState,
    reducers: {
        loginSuccess: (state, loginResponse: PayloadAction<LoginResponse>) => {
            state.jwt = loginResponse.payload.jwt
            state.simpleUser = loginResponse.payload.user
            localStorage.setItem("jwt", loginResponse.payload.jwt)
        },
        setJWT: (state, jwt: PayloadAction<string>) => {
            state.jwt = jwt.payload
        },
        logout: (state) => {
            state = initialState
            localStorage.removeItem("jwt")
        }
    },
})

export const { loginSuccess, logout, setJWT } = loginSlice.actions

export default loginSlice.reducer