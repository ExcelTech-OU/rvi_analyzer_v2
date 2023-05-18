import React from 'react';
import { Document, Page, Text, View, StyleSheet } from '@react-pdf/renderer';
import { ModeFiveDto, ModeOneDto, ModeThreeDto } from '../../services/sessions_service';

// Create styles
const styles = StyleSheet.create({
    page: {
        flexDirection: 'row',
        backgroundColor: '#E4E4E4',
        paddingTop: 35,
        paddingBottom: 125,
        paddingHorizontal: 35,
    },
    section: {
        margin: 10,
        padding: 10,
        flexGrow: 1
    },
    header: {
        marginBottom: 20 // Add margin to the header
    },
    headerText: {
        fontSize: 17,
        fontWeight: 'bold',
        marginBottom: 10
    },
    sessionText: {
        fontSize: 12,
        fontWeight: 'bold',
        color: "#000",
        marginBottom: 5
    },
    sessionTextPrefix: {
        fontSize: 13,
        fontWeight: 'bold',
        color: "#888",
        marginBottom: 5
    },
    row: {
        flexDirection: 'row'
    },
    tableContainer: {
        marginTop: 30,
        borderRadius: 5, // Add border radius for rounded corners
        overflow: 'hidden' // Ensure content within the container is clipped to the rounded corners
    },
    tableRowHeader: {
        flexDirection: 'row',
        borderBottomColor: '#000',
        alignItems: 'center',
        height: 30,
        backgroundColor: '#8888',
    },
    tableHeaderCell: {
        margin: "auto",
        marginTop: 5,
        fontSize: 10,
        backgroundColor: '#8888',
        color: '#FFF',
        fontWeight: 'bold',
        padding: 6
    },
    table: {
        display: "flex",
        width: "auto",
        borderStyle: "solid",
        borderWidth: 1,
        borderRightWidth: 0,
        borderBottomWidth: 0
    },
    tableRow: {
        margin: "auto",
        flexDirection: "row"
    },
    tableCol: {
        width: "15%",
        borderStyle: "solid",
        borderWidth: 1,
        borderLeftWidth: 0,
        borderTopWidth: 0
    },
    tableColMax: {
        width: "25%",
        borderStyle: "solid",
        borderWidth: 1,
        borderLeftWidth: 0,
        borderTopWidth: 0
    },
    tableColMin: {
        width: "10%",
        borderStyle: "solid",
        borderWidth: 1,
        borderLeftWidth: 0,
        borderTopWidth: 0
    },
    tableCell: {
        margin: "auto",
        marginTop: 5,
        fontSize: 10,
        height: 20,
        color: '#888'
    },
    label: {
        width: '20px',
        height: '20px',
        backgroundColor: '#FFF',
        borderRadius: '10px',
        justifyContent: 'center',
        alignItems: 'center',
    },
    textSuccess: {
        color: 'green',
        fontWeight: 'bold',
        fontSize: '10px',
    },
    textFail: {
        color: 'red',
        fontWeight: 'bold',
        fontSize: '10px',
    },
    pageNumber: {
        position: 'absolute',
        fontSize: 12,
        bottom: 30,
        left: 0,
        right: 0,
        textAlign: 'center',
        color: 'grey',
    },
    copyright: {
        position: 'absolute',
        fontSize: 12,
        bottom: 30,
        left: 0,
        right: 0,
        textAlign: 'center',
        color: 'grey',
        paddingBottom: 20,
    },
});

type ModeFivePdfDocumentProps = {
    session: ModeFiveDto;
}

// Create Document Component
function ModeFivePdfDocument({ session }: ModeFivePdfDocumentProps) {
    return (
        <Document>
            <Page size="A4" style={styles.page}>
                <View style={styles.section}>
                    <View style={styles.header}>
                        <Text style={styles.headerText}>Default Configurations</Text>
                        <Text style={styles.sessionTextPrefix}>Mode   : <Text style={styles.sessionText}>01</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Session Id   : <Text style={styles.sessionText}>{session.defaultConfigurations.sessionId}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Batch No   : <Text style={styles.sessionText}>{session.defaultConfigurations.batchNo}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Customer Name   : <Text style={styles.sessionText}>{session.defaultConfigurations.customerName}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Operator Id   : <Text style={styles.sessionText}>{session.defaultConfigurations.operatorId}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Test ID   : <Text style={styles.sessionText}>{session.results.testId}</Text> </Text>
                    </View>
                    <View>
                        <Text style={styles.headerText}>Session Configurations</Text>
                        <Text style={styles.sessionTextPrefix}>Fixed Voltage   : <Text style={styles.sessionText}>{session.sessionConfigurationModeFive.fixedVoltage}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Max Current   : <Text style={styles.sessionText}>{session.sessionConfigurationModeFive.maxCurrent}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Time Duration  : <Text style={styles.sessionText}>{session.sessionConfigurationModeFive.timeDuration}</Text> </Text>
                    </View>
                    <View style={styles.tableContainer}>
                        <View style={styles.tableRowHeader}>
                            <View style={styles.tableColMax}>
                                <Text style={styles.tableHeaderCell}>TIME (Sec)</Text>
                            </View>
                            <View style={styles.tableColMax}>
                                <Text style={styles.tableHeaderCell}>TEMPERATURE</Text>
                            </View>
                            <View style={styles.tableColMax}>
                                <Text style={styles.tableHeaderCell}>CURRENT</Text>
                            </View>
                            <View style={styles.tableColMax}>
                                <Text style={styles.tableHeaderCell}>VOLTAGE</Text>
                            </View>
                        </View>
                        {session.results.readings.map((item, index) => {
                            return (
                                <View style={styles.tableRow}>
                                    <View style={styles.tableColMax}>
                                        <Text style={styles.tableCell}>{(index + 1)}</Text>
                                    </View>
                                    <View style={styles.tableColMax}>
                                        <Text style={styles.tableCell}>{item.temperature}</Text>
                                    </View>
                                    <View style={styles.tableColMax}>
                                        <Text style={styles.tableCell}>{item.current}</Text>
                                    </View>
                                    <View style={styles.tableColMax}>
                                        <Text style={styles.tableCell}>{item.voltage}</Text>
                                    </View>
                                </View>
                            );
                        })}

                    </View>
                </View>
                <Text style={styles.copyright} fixed> &copy; 2023 RVi. All rights reserved.</Text>
                <Text style={styles.pageNumber} render={({ pageNumber, totalPages }) => (
                    ` ${pageNumber} / ${totalPages} `
                )} fixed />
            </Page>
        </Document >
    );
}

export default ModeFivePdfDocument;