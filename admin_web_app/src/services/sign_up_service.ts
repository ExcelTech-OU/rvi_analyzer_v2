import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export interface SignUpResponse {
    state: string
    stateDescription: string
    user: SimpleUser
    jwt: string
    roles: string[]
}

export interface RolesResponse {
    status: string
    statusDescription: string
    user: SimpleUser
    roles: string[]
}

export interface SimpleUser {
    username: string
    group: string
    status: string
    createdBy: string
    createdDateTime: string
}

export const signUpApi = createApi({
    reducerPath: 'signUpApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://127.0.0.1:7550/' }),
    tagTypes: ['signUpRequest'],
    endpoints: (build) => ({
        signUp: build.mutation<SignUpResponse, {}>({
            query(body) {
                return {
                    url: `register/user`,
                    method: 'POST',
                    body,
                }
            },
        }),
    }),
})

export const {
    useSignUpMutation
} = signUpApi