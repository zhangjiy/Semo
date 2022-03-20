//
//  JYPaintingView.swift
//  Semo
//
//  Created by jiyang on 2022/3/20.
//

import Foundation
import UIKit
import MaLiang
import Comet
import Chrysan
import Zip

class JYPaintingView: UIView {
    
    var strokeSizeLabel: UILabel!
    var brushSegement: UISegmentedControl!
    var sizeSlider: UISlider!
    var undoButton: UIButton!
    var redoButton: UIButton!
    var backgroundSwitchButton: UIButton!
    var backgroundView: UIImageView!
    
    var canvas: Canvas!
    
    var filePath: String?
    
    var brushes: [Brush] = []
    var chartlets: [MLTexture] = []
    
    var color: UIColor {
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    private func registerBrush(with imageName: String) throws -> Brush {
        let texture = try canvas.makeTexture(with: UIImage(named: imageName)!.pngData()!)
        return try canvas.registerBrush(name: imageName, textureID: texture.id)
    }
    
   override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConfig()
        registerBrushes()
        readDataIfNeeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfig() {
        chartlets = ["chartlet-1", "chartlet-2", "chartlet-3"].compactMap({ (name) -> MLTexture? in
            return try? canvas.makeTexture(with: UIImage(named: name)!.pngData()!)
        })
        canvas.backgroundColor = .clear
        canvas.data.addObserver(self)
    }
    
    private func setupView() {
        backgroundView = UIImageView(frame:bounds)
        addSubview(backgroundView)
        canvas = Canvas(frame: bounds)
        addSubview(canvas)
        brushSegement = UISegmentedControl(items: ["pen", "pencil", "brush"])
        //brushSegement.addTarget(self, action: #selector("styleChanged"), for: .touchUpInside)
        addSubview(brushSegement)
        
        undoButton = UIButton(frame: CGRect(x: 0, y: 400, width: 40, height: 40))
        addSubview(undoButton)
        
        redoButton = UIButton(frame: CGRect(x: 0, y: 450, width: 40, height: 40))
        addSubview(redoButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds
        canvas.frame = bounds
    }
    
    func registerBrushes() {
        do {
            let pen = canvas.defaultBrush!
            pen.name = "Pen"
            pen.pointSize = 5
            pen.pointStep = 0.5
            pen.color = color
            
            let pencil = try registerBrush(with: "pencil")
            pencil.rotation = .random
            pencil.pointSize = 3
            pencil.pointStep = 2
            pencil.forceSensitive = 0.3
            pencil.opacity = 1
            
            let brush = try registerBrush(with: "brush")
            brush.opacity = 1
            brush.rotation = .ahead
            brush.pointSize = 15
            brush.pointStep = 1
            brush.forceSensitive = 1
            brush.color = color
            brush.forceOnTap = 0.5
            
            let texture = try canvas.makeTexture(with: UIImage(named: "glow")!.pngData()!)
            let glow: GlowingBrush = try canvas.registerBrush(name: "glow", textureID: texture.id)
            glow.opacity = 0.5
            glow.coreProportion = 0.2
            glow.pointSize = 20
            glow.rotation = .ahead
            
            let claw = try registerBrush(with: "claw")
            claw.rotation = .ahead
            claw.pointSize = 30
            claw.pointStep = 5
            claw.forceSensitive = 0.1
            claw.color = color
            
            /// make a chartlet brush
            let chartletBrush = try ChartletBrush(name: "Chartlet", imageNames: ["rect-1", "rect-2", "rect-3"], target: canvas)
            chartletBrush.renderStyle = .ordered
            chartletBrush.rotation = .random
            
            // make eraser with a texture for claw
            //            let eraser = try canvas.registerBrush(name: "Eraser", textureID: claw.textureID) as Eraser
            //            eraser.rotation = .ahead
            
            /// make eraser with default round point
            let eraser = try! canvas.registerBrush(name: "Eraser") as Eraser
            eraser.opacity = 1
            
            brushes = [pen, pencil, brush, glow, claw, chartletBrush, eraser]
            
        } catch MLError.simulatorUnsupported {
            let alert = UIAlertController(title: "Attension", message: "You are running MaLiang on a Simulator, whitch is not supported by Metal. So painting is not alvaliable now. But you can go on testing your other businesses which are not relative with MaLiang. Or you can also runs MaLiang on your Mac with Catalyst enabled now.", preferredStyle: .alert)
            alert.addAction(title: "确定", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(title: "确定", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
        }
        
        brushSegement.removeAllSegments()
        for i in 0 ..< brushes.count {
            let name = brushes[i].name
            brushSegement.insertSegment(withTitle: name, at: i, animated: false)
        }
        
        if brushes.count > 0 {
            brushSegement.selectedSegmentIndex = 0
            styleChanged(brushSegement)
        }
    }
    
    @IBAction func switchBackground(_ sender: UIButton) {
        sender.isSelected.toggle()
        backgroundView.isHidden = !sender.isSelected
    }
    
    @IBAction func changeSizeAction(_ sender: UISlider) {
        let size = Int(sender.value)
        canvas.currentBrush.pointSize = CGFloat(size)
        strokeSizeLabel.text = "\(size)"
    }
    
    func styleChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let brush = brushes[index]
        brush.color = color
        brush.use()
        strokeSizeLabel.text = "\(brush.pointSize)"
        sizeSlider.value = Float(brush.pointSize)
    }
    
    @IBAction func togglePencilMode(_ sender: UISwitch) {
        canvas.isPencilMode = sender.isOn
    }
    
    @IBAction func undoAction(_ sender: Any) {
        canvas.undo()
    }
    
    @IBAction func redoAction(_ sender: Any) {
        canvas.redo()
    }
    
    @IBAction func clearAction(_ sender: Any) {
        canvas.clear()
    }
    
    @IBAction func moreAction(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Choose Actions", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(title: "Add Chartlet", style: .default) { [unowned self] (_) in
            self.addChartletAction()
        }
        actionSheet.addAction(title: "Snapshot", style: .default) { [unowned self] (_) in
            self.snapshotAction(sender)
        }
        actionSheet.addAction(title: "Save", style: .default) { [unowned self] (_) in
            self.saveData()
        }
        actionSheet.addAction(title: "Cancel", style: .cancel)
        actionSheet.popoverPresentationController?.barButtonItem = sender
        //present(actionSheet, animated: true, completion: nil)
    }
    
    func addChartletAction() {
//        ChartletPicker.present(from: self, textures: chartlets) { [unowned self] (texture) in
//            self.showEditor(for: texture)
//        }
    }
    
    func showEditor(for texture: MLTexture) {
//        ChartletEditor.present(from: self, for: texture) { [unowned self] (editor) in
//            let result = editor.convertCoordinate(to: self.canvas)
//            self.canvas.renderChartlet(at: result.center, size: result.size, textureID: texture.id, rotation: result.angle)
//        }
    }
    
    func snapshotAction(_ sender: Any) {
//        let preview = PaintingPreview.create(from: .main)
//        preview.image = canvas.snapshot()
        //navigationController?.pushViewController(preview, animated: true)
    }
    
    func saveData() {
        //self.chrysan.showMessage("Saving...")
        let exporter = DataExporter(canvas: canvas)
        let path = Path.temp().resource(Date().string())
        path.createDirectory()
        exporter.save(to: path.url, progress: { (progress) in
            //self.chrysan.show(progress: progress, message: "Saving...")
        }) { (result) in
            if case let .failure(error) = result {
                self.chrysan.hide()
                let alert = UIAlertController(title: "Saving Failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(title: "OK", style: .cancel)
                //self.present(alert, animated: true, completion: nil)
            } else {
                let filename = "\(Date().string(format: "yyyyMMddHHmmss")).maliang"
                
                let contents = try! FileManager.default.contentsOfDirectory(at: path.url, includingPropertiesForKeys: [], options: .init(rawValue: 0))
                try? Zip.zipFiles(paths: contents, zipFilePath: Path.documents().resource(filename).url, password: nil, progress: nil)
                try? FileManager.default.removeItem(at: path.url)
                //self.chrysan.show(.succeed, message: "Saving Succeed!", hideDelay: 1)
            }
        }
    }
    
    func readDataIfNeeds() {
        guard let file = filePath else {
            return
        }
        //chrysan.showMessage("Reading...")
        
        let path = Path(file)
        let temp = Path.temp().resource("temp.zip")
        let contents = Path.temp().resource("contents")
        
        do {
            try? FileManager.default.removeItem(at: temp.url)
            try FileManager.default.copyItem(at: path.url, to: temp.url)
            try Zip.unzipFile(temp.url, destination: contents.url, overwrite: true, password: nil)
        } catch {
            self.chrysan.hide()
            let alert = UIAlertController(title: "unzip failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(title: "OK", style: .cancel)
            //self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        DataImporter.importData(from: contents.url, to: canvas, progress: { (progress) in
            
        }) { (result) in
            if case let .failure(error) = result {
                self.chrysan.hide()
                let alert = UIAlertController(title: "Reading Failed", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(title: "OK", style: .cancel)
                //self.present(alert, animated: true, completion: nil)
            } else {
                //self.chrysan.show(.succeed, message: "Reading Succeed!", hideDelay: 1)
            }
            
        }
    }
    
    // MARK: - color
    @IBOutlet weak var colorSampleView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var rl: UILabel!
    @IBOutlet weak var gl: UILabel!
    @IBOutlet weak var bl: UILabel!
    
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    
    @IBAction func colorChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        let colorv = CGFloat(value) / 255
        switch sender.tag {
        case 0:
            r = colorv
            rl.text = "\(value)"
        case 1:
            g = colorv
            gl.text = "\(value)"
        case 2:
            b = colorv
            bl.text = "\(value)"
        default: break
        }
        
        colorSampleView.backgroundColor = color
        canvas.currentBrush.color = color
    }
}

extension JYPaintingView: DataObserver {
    /// called when a line strip is begin
    func lineStrip(_ strip: LineStrip, didBeginOn data: CanvasData) {
        self.redoButton.isEnabled = false
    }
    
    /// called when a element is finished
    func element(_ element: CanvasElement, didFinishOn data: CanvasData) {
        self.undoButton.isEnabled = true
    }
    
    /// callen when clear the canvas
    func dataDidClear(_ data: CanvasData) {
        
    }
    
    /// callen when undo
    func dataDidUndo(_ data: CanvasData) {
        self.undoButton.isEnabled = true
        self.redoButton.isEnabled = data.canRedo
    }
    
    /// callen when redo
    func dataDidRedo(_ data: CanvasData) {
        self.undoButton.isEnabled = true
        self.redoButton.isEnabled = data.canRedo
    }
}

extension String {
    var floatValue: CGFloat {
        let db = Double(self) ?? 0
        return CGFloat(db)
    }
}


