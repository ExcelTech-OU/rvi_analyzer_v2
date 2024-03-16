import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'
import { List } from 'reselect/es/types'

export interface TestsListResponse {
    status: string
    statusDescription: string
    tests: List<Test>
}

export interface Test {
    material: string
    testGate: string
    parameterModes: List<ParameterMode>
    createdBy: string,
    createdDateTime: string
}

export interface ParameterMode{
    name: string
    parameter: string
}

export interface TestGetResponse {
    status: string,
    statusDescription: string,
    name: string
}

export const testApi = createApi({
    reducerPath: 'testApi',
    baseQuery: fetchBaseQuery({
        baseUrl: 'http://rvi.v2.exceltch.com/rvi-analyzer-api/',
        prepareHeaders: (headers) => {
            const token = localStorage.getItem("jwt") as string;
            if (!headers.has("Authorization") && token) {
                headers.set("Authorization", `Bearer ${token}`);
            }
            return headers;
        },
    }),
    tagTypes: ['testList'],
    endpoints: (build) => ({
        getTest: build.query<TestsListResponse, {}>({
            query: () => `rvi/analyzer/v1/tests`,
            providesTags: [{ type: 'testList', id: "getTests" }]

        }),
        addTest: build.mutation<TestGetResponse, {}>({
            query(body) {
                return {
                    url: `register/test`,
                    method: 'POST',
                    body: body,
                }
            },
            invalidatesTags: [{ type: 'testList', id: "getTests" }]
        }),
    }),
})

export const {
    useGetTestQuery,
    useAddTestMutation,
} = testApi