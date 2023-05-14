import { Document, Page, Text, View, StyleSheet } from '@react-pdf/renderer';
import { ModeFourDto } from '../../services/sessions_service';

// Create styles
const styles = StyleSheet.create({
    page: {
        flexDirection: 'row',
        backgroundColor: '#E4E4E4',
        padding: 20 // Add padding to the page
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
});

type ModeFourPdfDocumentProps = {
    session: ModeFourDto;
}

// Create Document Component
function ModeFourPdfDocument({ session }: ModeFourPdfDocumentProps) {
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
                        <Text style={styles.sessionTextPrefix}>Starting Current   : <Text style={styles.sessionText}>{session.sessionConfigurationModeFour.startingCurrent}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Desired Current  : <Text style={styles.sessionText}>{session.sessionConfigurationModeFour.desiredCurrent}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Max Voltage   : <Text style={styles.sessionText}>{session.sessionConfigurationModeFour.maxVoltage}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Current Resolution  : <Text style={styles.sessionText}>{session.sessionConfigurationModeFour.currentResolution}</Text> </Text>
                        <Text style={styles.sessionTextPrefix}>Charge In Time   : <Text style={styles.sessionText}>{session.sessionConfigurationModeFour.chargeInTime} Sec</Text> </Text>
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
                                        <Text style={styles.tableCell}>{parseFloat(session.sessionConfigurationModeFour.chargeInTime) * (index + 1)}</Text>
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

            </Page>
        </Document >
    );
}

export default ModeFourPdfDocument;