import { createSlice } from '@reduxjs/toolkit'
import type { PayloadAction } from '@reduxjs/toolkit'
// import { LoginResponse, RolesResponse, SimpleUser } from '../../../services/login_service'
import { SignUpResponse, RolesResponse, SimpleUser } from '../../../services/sign_up_service'

interface SignUpSlice {
    simpleUser: SimpleUser | null
    jwt: string | null,
    roles: string[]
}

const initialState: SignUpSlice = {
    simpleUser: null,
    jwt: null,
    roles: []
}

export const signUpSlice = createSlice({
    name: 'signUp',
    initialState,
    reducers: {
        signUpSuccess: (state, SignUpResponse: PayloadAction<SignUpResponse>) => {
            state.jwt = SignUpResponse.payload.jwt
            state.simpleUser = SignUpResponse.payload.user
            localStorage.setItem("jwt", SignUpResponse.payload.jwt)
        },
        setJWT: (state, jwt: PayloadAction<string>) => {
            state.jwt = jwt.payload
        },
        signOut: (state) => {
            state = initialState
            localStorage.removeItem("jwt")
        },
        rolesGetSuccess: (state, rolesResponse: PayloadAction<RolesResponse>) => {
            state.simpleUser = rolesResponse.payload.user
            state.roles = rolesResponse.payload.roles
        },
    },
})

export const { signUpSuccess, signOut, setJWT, rolesGetSuccess } = signUpSlice.actions

export default signUpSlice.reducer